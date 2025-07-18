//
//  HabitEntity.swift
//  LoomeApp
//
//  Created by Onie on 7/17/25.
//

import Foundation
import SwiftData
@Model
class HabitEntity {
    var id: UUID
    var title: String
    var message: String?
    var creationDate: Date
    var finishDate: Date?
    var frequencyRaw: Data
    var isArchived: Bool
    var levelsRaw: Data
    var completionHistoryRaw: Data

    init(
        id: UUID,
        title: String,
        message: String?,
        creationDate: Date,
        finishDate: Date?,
        frequencyRaw: Data,
        isArchived: Bool,
        levelsRaw: Data,
        completionHistoryRaw: Data
    ) {
        self.id = id
        self.title = title
        self.message = message
        self.creationDate = creationDate
        self.finishDate = finishDate
        self.frequencyRaw = frequencyRaw
        self.isArchived = isArchived
        self.levelsRaw = levelsRaw
        self.completionHistoryRaw = completionHistoryRaw
    }
}

extension HabitEntity {
    func toDomain() -> Habit {
        let frequency = (try? JSONDecoder().decode(Frequency.self, from: frequencyRaw)) ?? .daily
        let levels = (try? JSONDecoder().decode([HabitLevel].self, from: levelsRaw)) ?? []
        let history = (try? JSONDecoder().decode([Date: HabitLevel?].self, from: completionHistoryRaw)) ?? [:]

        return Habit(
            id: id,
            title: title,
            description: message,
            creationDate: creationDate,
            finishDate: finishDate,
            frequency: frequency,
            isArchived: isArchived,
            levels: levels,
            completionHistory: history
        )
    }
}


extension Habit {
    func toEntity() -> HabitEntity {
        let frequencyRaw = try! JSONEncoder().encode(frequency)
        let levelsRaw = try! JSONEncoder().encode(levels)
        let historyRaw = try! JSONEncoder().encode(completionHistory)

        return HabitEntity(
            id: id,
            title: title,
            message: description,
            creationDate: creationDate,
            finishDate: finishDate,
            frequencyRaw: frequencyRaw,
            isArchived: isArchived,
            levelsRaw: levelsRaw,
            completionHistoryRaw: historyRaw
        )
    }
}
