//
//  HomeFeature.swift
//  LoomeApp
//
//  Created by Onie on 4/29/25.
//

import Foundation
import ComposableArchitecture


struct Habit: Equatable, Identifiable {
    let id: UUID
    var name: String
}

@Reducer
struct HomeFeature {
    @ObservableState
    struct State: Equatable {
        @Presents var addHabit: AddHabitFeature.State?
        var habits: IdentifiedArrayOf<Habit> = []
    }
    enum Action {
        case addButtonTapped
        case addHabit(PresentationAction<AddHabitFeature.Action>)
    }
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.addHabit = AddHabitFeature.State(
                    habit: Habit(id: UUID(), name: "")
                )
                return .none

            case .addHabit(.presented(.cancelButtonTapped)):
                state.addHabit = nil
                return .none

            case .addHabit(.presented(.saveButtonTapped)):
                guard let habit = state.addHabit?.habit
                else { return .none }
                state.habits.append(habit)
                state.addHabit = nil
                return .none


            case .addHabit:
                return .none
            }
        }
        .ifLet(\.$addHabit, action: \.addHabit) {
            AddHabitFeature()
        }
    }
}
