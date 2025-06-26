//
//  ThemeMode.swift
//  LoomeApp
//
//  Created by Onie on 6/5/25.
//

import SwiftUI

// MARK: - Theme Mode Enum
enum ThemeMode: String, CaseIterable, Equatable, Identifiable {
    case light
    case dark
    case system

    var id: String { rawValue }

    /// Corresponding ColorScheme: nil = system settings
    var colorScheme: ColorScheme? {
        switch self {
        case .light: return .light
        case .dark: return .dark
        case .system: return nil
        }
    }

    var displayName: String {
        switch self {
        case .light: return "Light"
        case .dark: return "Dark"
        case .system: return "System"
        }
    }
}
