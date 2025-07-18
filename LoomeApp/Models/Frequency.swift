//
//  Frequency.swift
//  LoomeApp
//
//  Created by Onie on 7/2/25.
//

import Foundation

enum Frequency: Equatable, Codable {

    case daily
    case weekly
    case mounthly
    case custom(daysOfWeek: [Weekday])
}

