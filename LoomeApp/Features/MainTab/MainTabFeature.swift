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
    enum Tab {
        case home
        case habits
        case stats
        case settings
        case addHabit
    }

    struct State {
        var selectedTab: Tab = .home

        var habits: IdentifiedArrayOf<Habit> = []
        var homeTab = HomeFeature.State()
        var allHabitsTab = AllHabitsFeature.State()
        var statsTab = StatsFeature.State()
        var settingsTab = SettingsFeature.State()
        var addHabitTab = AddHabitFeature.State(habit: Habit(id: UUID(), title: ""))
    }

    enum Action {
        case homeTab(HomeFeature.Action)
        case allHabitsTab(AllHabitsFeature.Action)
        case statsTab(StatsFeature.Action)
        case settingsTab(SettingsFeature.Action)
        case addHabitTab(AddHabitFeature.Action)

        case selectedTabChanged(Tab)

        case syncHabits
    }

    @Dependency(\.uuid) var uuid

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
        Scope(state:\.addHabitTab, action: \.addHabitTab){
            AddHabitFeature()
        }
        Reduce { state, action in
            switch action {

            case let .allHabitsTab(.delegate(.deleteHabit(id))):
                state.habits.remove(id: id)
                print(state.habits)
                return .send(.syncHabits)

            case let .addHabitTab(.delegate(.saveHabit(habit))):
                state.habits.append(habit)
                return .concatenate(
                    .send(.syncHabits),
                    .send(.selectedTabChanged(.home))
                )

            case .selectedTabChanged(let tab):
                state.selectedTab = tab

                // State needs to be recreated in order to create new habit ID  each time user taps on AddHabit tab 
                if tab == .addHabit {
                    state.addHabitTab = AddHabitFeature.State(
                        habit: Habit(id: uuid(), title: "")
                    )
                }

                return .none

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
