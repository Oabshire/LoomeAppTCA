//
//  WeekDay.swift
//  LoomeApp
//
//  Created by Onie on 7/2/25.
//

enum Weekday: String, Codable, CaseIterable, Identifiable {
    case sunday, monday, tuesday, wednesday, thursday, friday, saturday

    var id: String { self.rawValue }

    var localizedName: String {
        switch self {
        case .sunday: return "S"
        case .monday: return "M"
        case .tuesday: return "T"
        case .wednesday: return "W"
        case .thursday: return "T"
        case .friday: return "F"
        case .saturday: return "S"
        }
    }
}
