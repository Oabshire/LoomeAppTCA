//
//  UserSettingsCore.swift
//  LoomeApp
//
//  Created by Onie on 4/30/25.
//

import Foundation
import ComposableArchitecture

// MARK: - Updated UserSettings Reducer
@Reducer
struct UserSettings {
    struct State: Equatable {
        var themeMode: ThemeMode

        public init(themeMode: ThemeMode = .system) {
            self.themeMode = themeMode
        }
    }

    enum Action: Equatable {
        case onAppear
        case themeModeChanged(ThemeMode)
        case closeButtonTapped
        case themeLoaded(ThemeMode)
    }

    @Dependency(\.themeManager) var themeManager
    @Dependency(\.mainQueue) var mainQueue

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                let savedTheme = themeManager.loadTheme()
                return .send(.themeLoaded(savedTheme))

            case .themeLoaded(let theme):
                state.themeMode = theme
                return .none

            case .themeModeChanged(let newMode):
                print("THEME MODE CHANGED: \(newMode)")
                // Only update if theme actually changed
                guard themeManager.shouldUpdateTheme(from: state.themeMode, to: newMode) else {
                    return .none
                }

                state.themeMode = newMode
                themeManager.saveTheme(newMode)
                print("THEME MODE UPDATED: \( state.themeMode)")

                return .none

            case .closeButtonTapped:
                return .none
            }
        }
    }
}
