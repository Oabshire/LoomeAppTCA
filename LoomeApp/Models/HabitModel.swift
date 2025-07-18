//
//  HabitModel.swift
//  LoomeApp
//
//  Created by Onie on 7/2/25.
//

import Foundation
import SwiftUI

struct Habit: Identifiable, Equatable {
    let id: UUID
    var title: String
    var description: String?
    var creationDate: Date
    var finishDate: Date?
    var frequency: Frequency
    var isArchived: Bool
    var levels: [HabitLevel]

    var completionHistory: [Date: HabitLevel?]


    init(
        id: UUID = UUID(),
        title: String,
        description: String? = nil,
        creationDate: Date = Date(),
        finishDate: Date? = nil,
        frequency: Frequency = .daily,
        isArchived: Bool = false,
        levels: [HabitLevel] = [.standart],
        completionHistory: [Date: HabitLevel?] = [:]
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.creationDate = creationDate
        self.frequency = frequency
        self.isArchived = isArchived
        self.levels = levels
        self.completionHistory = completionHistory
    }

    var isCompletedToday: Bool {
        return completionHistory.contains { completion in
            Calendar.current.isDateInToday(completion.key)
        }
    }
}
