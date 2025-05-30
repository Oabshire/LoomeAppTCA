//
//  ThemeManager.swift
//  LoomeApp
//
//  Created by Onie on 5/30/25.
//

import SwiftUI
import ComposableArchitecture

// MARK: - Thread-Safe Theme Manager
struct ThemeManager: Sendable {
    private let userDefaults: UserDefaultsClient
    private let queue = DispatchQueue(label: "theme.manager.queue", qos: .userInitiated)

    init(userDefaults: UserDefaultsClient) {
        self.userDefaults = userDefaults
    }

    /// Load theme from persistent storage
    func loadTheme() -> ThemeMode {
        userDefaults.loadTheme() ?? .system
    }

    /// Save theme to persistent storage (thread-safe)
    func saveTheme(_ theme: ThemeMode) {
        queue.async {
            userDefaults.saveTheme(theme)
        }
    }

    /// Get the actual color scheme that should be applied

    func actualColorScheme(_ theme: ThemeMode, systemScheme: ColorScheme) -> ColorScheme {
        theme.colorScheme ?? systemScheme
    }

    /// Validate if theme change is needed
    func shouldUpdateTheme(from current: ThemeMode, to new: ThemeMode) -> Bool {
        current != new
    }
}


// MARK: - Theme Manager Dependency
private enum ThemeManagerKey: DependencyKey {
    static let liveValue = ThemeManager(userDefaults: .liveValue)
    static let testValue = ThemeManager(userDefaults: .testValue)
}

extension DependencyValues {
    var themeManager: ThemeManager {
        get { self[ThemeManagerKey.self] }
        set { self[ThemeManagerKey.self] = newValue }
    }
}
