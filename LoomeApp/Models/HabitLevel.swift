//
//  HabitLevel.swift
//  LoomeApp
//
//  Created by Onie on 7/2/25.
//

import Foundation

struct HabitLevel: Codable, Equatable {
    var label: String
    var description: String?

    init(label: String, description: String? = nil) {
        self.label = label
        self.description = description
    }

    static var defaultLevels: [HabitLevel] {
        [
            HabitLevel(label: "Minimum", description: "The least you can do"),
            HabitLevel(label: "Standard", description: "Your usual amount"),
            HabitLevel(label: "Full Energy", description: "When you feel inspired")
        ]
    }
}
