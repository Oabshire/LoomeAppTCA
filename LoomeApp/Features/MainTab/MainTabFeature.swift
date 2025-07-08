//
//  MainTabFeature.swift
//  LoomeApp
//
//  Created by Onie on 6/17/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MainTabFeature {
    struct State {
        var habits: IdentifiedArrayOf<Habit> = []
        var homeTab = HomeFeature.State()
        var allHabitsTab = AllHabitsFeature.State()
        var statsTab = StatsFeature.State()
        var settingsTab = SettingsFeature.State()
    }

    enum Action {
        case homeTab(HomeFeature.Action)
        case allHabitsTab(AllHabitsFeature.Action)
        case statsTab(StatsFeature.Action)
        case settingsTab(SettingsFeature.Action)

        case syncHabits
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.homeTab, action: \.homeTab) {
            HomeFeature()
        }
        Scope(state: \.allHabitsTab, action: \.allHabitsTab) {
            AllHabitsFeature()
        }
        Scope(state: \.statsTab,action: \.statsTab) {
            StatsFeature()
        }
        Scope(state: \.settingsTab, action: \.settingsTab) {
            SettingsFeature()
        }
        Reduce { state, action in
            switch action {
            case let .homeTab(.delegate(.addHabit(habit))):
                state.habits.append(habit)
                return  .send(.syncHabits)

            case let .allHabitsTab(.delegate(.addHabit(habit))):
                state.habits.append(habit)
                return  .send(.syncHabits)

            case let .allHabitsTab(.delegate(.deleteHabit(id))):
                state.habits.remove(id: id)
                print(state.habits)
                return .send(.syncHabits)

            case .syncHabits:
                print(state.habits)
                state.homeTab.habits = state.habits.filter { !$0.isArchived }
                state.allHabitsTab.habits = state.habits
                return .none
            default:
                return .none
            }
        }
    }
}
