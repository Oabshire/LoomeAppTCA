//
//  Frequency.swift
//  LoomeApp
//
//  Created by Onie on 7/2/25.
//

import Foundation

enum Frequency: Equatable {
    case daily
    case weekly
    case custom(daysOfWeek: [Weekday])

    enum FrequencyType: String {
        case daily, weekly, mounthly, custom
    }
}

