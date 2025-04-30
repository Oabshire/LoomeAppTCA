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

        @PresentationState var userSettings: UserSettings.State?
    }

    enum Action {
        case tabSelected(Tab)
        case home(Home.Action)
        case addHabit(AddHabit.Action)
        case stats(Stats.Action)
        case userSettings(PresentationAction<UserSettings.Action>)
    }


    enum Tab: Int {
        case home, addHabit, stats
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {

            case .home(.settingsButtonTapped),
                    .addHabit(.settingsButtonTapped),
                    .stats(.settingsButtonTapped):
                state.userSettings = UserSettings.State()
                return .none

            case .userSettings(.presented(.closeButtonTapped)):
                state.userSettings = nil
                return .none

            default:
                return .none
            }
        }
        .ifLet(\.$userSettings, action: \.userSettings) {
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
    }
}
