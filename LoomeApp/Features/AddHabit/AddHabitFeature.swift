//
//  AddHabitFeature.swift
//  LoomeApp
//
//  Created by Onie on 4/29/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AddHabitFeature {
    @ObservableState
    struct State: Equatable {
        var habit: Habit
    }
    enum Action {
        case delegate(Delegate)
        case saveButtonTapped
        case setName(String)
        @CasePathable
        enum Delegate: Equatable {
            case saveHabit(Habit)
        }
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .delegate:
                return .none

            case .saveButtonTapped:
                return .run { [habit = state.habit] send in
                    await send(.delegate(.saveHabit(habit)))
                }

            case let .setName(name):
                state.habit.title = name
                return .none
            }
        }
    }
}
