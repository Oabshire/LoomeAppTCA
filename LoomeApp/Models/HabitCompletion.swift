//
//  HabitCompletion.swift
//  LoomeApp
//
//  Created by Onie on 7/2/25.
//

import Foundation
struct HabitCompletion: Codable, Equatable, Identifiable {
    let id: UUID
    let date: Date
    let levelLabel: String?

    init(id: UUID = UUID(), date: Date = Date(), levelLabel: String? = nil) {
        self.id = id
        self.date = date
        self.levelLabel = levelLabel
    }
}
