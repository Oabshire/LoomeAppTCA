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

        case syncHabits

        case selectedTabChanged(Tab)

        case onApear
    }

    @Dependency(\.uuid) var uuid
    @Dependency(\.swiftData) var context

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
                do {
                    try context.delete(id)
                    state.habits.remove(id: id)
                } catch (let error) {
                    print (error)
                }
                return .send(.syncHabits)

            case let .addHabitTab(.delegate(.saveHabit(habit))):
                do {
                    try context.add(habit)
                    state.habits.append(habit)
                } catch (let error ) {
                    print (error)
                }
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

            case .onApear:
                do {
                    let allHabits = try context.fetchAll()

                    state.habits = IdentifiedArrayOf<Habit>(uniqueElements: allHabits)
                } catch(let error ) {
                    print (error)
                }

                return .send(.syncHabits)

            default:
                return .none
            }
        }
    }
}
