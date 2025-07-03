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

    var completionHistory: [HabitCompletion]


    init(
        id: UUID = UUID(),
        title: String,
        description: String? = nil,
        creationDate: Date = Date(),
        finishDate: Date? = nil,
        frequency: Frequency = .daily,
        isArchived: Bool = false,
        levels: [HabitLevel] = HabitLevel.defaultLevels,
        completionHistory: [HabitCompletion] = []
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
        let calendar = Calendar.current
        return completionHistory.contains { calendar.isDateInToday($0.date) }
    }
}
