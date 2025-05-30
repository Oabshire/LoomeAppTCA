//
//  UserDefaultsClient.swift
//  LoomeApp
//
//  Created by Onie on 5/29/25.
//

import SwiftUI
import ComposableArchitecture

// MARK: - UserDefaults Client
struct UserDefaultsClient: Sendable {
    var loadTheme: @Sendable () -> ThemeMode?
    var saveTheme: @Sendable (ThemeMode) -> Void
}

extension UserDefaultsClient: DependencyKey {
    static let liveValue = UserDefaultsClient(
        loadTheme: {
            guard let rawValue = UserDefaults.standard.string(forKey: "theme_mode") else {
                return nil
            }
            return ThemeMode(rawValue: rawValue)
        },
        saveTheme: { theme in
            UserDefaults.standard.set(theme.rawValue, forKey: "theme_mode")
        }
    )

    static let testValue = UserDefaultsClient(
        loadTheme: { .system },
        saveTheme: { _ in }
    )
}

extension DependencyValues {
    var userDefaults: UserDefaultsClient {
        get { self[UserDefaultsClient.self] }
        set { self[UserDefaultsClient.self] = newValue }
    }
}
