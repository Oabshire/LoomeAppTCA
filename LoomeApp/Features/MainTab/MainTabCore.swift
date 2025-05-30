//
//  MainTabCore.swift
//  LoomeApp
//
//  Created by Onie on 4/29/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MainTab {
    struct State: Equatable {
        var selectedTab: Tab = .home
        var home = Home.State()
        var addHabit = AddHabit.State()
        var stats = Stats.State()

        var themeMode: ThemeMode = .system

        var userSettings: UserSettings.State {
            get {
                .init( themeMode: themeMode )
            }
            set {
                themeMode = newValue.themeMode
            }
        }

        @BindingState var isSettingsViewPresent = false
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)

        case onAppear
        case tabSelected(Tab)
        case home(Home.Action)
        case addHabit(AddHabit.Action)
        case stats(Stats.Action)
        case userSettings(UserSettings.Action)
    }

    enum Tab: Int {
        case home, addHabit, stats
    }

    var body: some ReducerOf<Self> {
        BindingReducer()

        Scope(state: \.userSettings, action: \.userSettings) {
            UserSettings()
        }

        Scope(state: \.home, action: \.home) {
            Home()
        }

        Scope(state: \.addHabit, action: \.addHabit) {
            AddHabit()
        }

        Scope(state: \.stats, action: \.stats) {
            Stats()
        }

        Reduce { state, action in
            switch action {
            case .binding:
                return .none

            case .onAppear:
                return .send(.userSettings(.onAppear))

            case .home(.settingsButtonTapped),
                    .addHabit(.settingsButtonTapped),
                    .stats(.settingsButtonTapped):
                state.isSettingsViewPresent = true
                return .none

            case .userSettings(.closeButtonTapped):
                state.isSettingsViewPresent = false
                return .none

            default:
                return .none
            }
        }
    }
}
