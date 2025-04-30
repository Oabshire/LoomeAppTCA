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
        var search = AddHabit.State()
        var profile = Stats.State()
    }

    enum Action {
        case tabSelected(Tab)
        case home(Home.Action)
        case search(AddHabit.Action)
        case profile(Stats.Action)
    }

    enum Tab: Int {
        case home, search, profile
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .tabSelected(tab):
                state.selectedTab = tab
                return .none

            default:
                return .none
            }
        }
        Scope(state: \.home, action: \.home) {
            Home()
        }
        Scope(state: \.search, action: \.search) {
            AddHabit()
        }
        Scope(state: \.profile, action: \.profile) {
            Stats()
        }
    }
}
