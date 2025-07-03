//
//  AllHabitsFeature.swift
//  LoomeApp
//
//  Created by Onie on 7/3/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AllHabitsFeature {
    @ObservableState
    struct State {
        @Presents var destination: Destination.State?
        var habits: IdentifiedArrayOf<Habit> = []
        var path = StackState<HabitDetailFeature.State>()
    }

    enum Action {
        case addButtonTapped
        case destination(PresentationAction<Destination.Action>)
        case path(StackActionOf<HabitDetailFeature>)

        @CasePathable
        enum Alert: Equatable {
            case confirmDeletion(id: Habit.ID)
        }
    }

    @Dependency(\.uuid) var uuid

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.destination = .addHabit(
                    AddHabitFeature.State(
                        habit: Habit(id: self.uuid(), title: "")
                    )
                )
                return .none

            case let .destination(.presented(.addHabit(.delegate(.saveHabit(habit))))):
                state.habits.append(habit)
                return .none

            case let .destination(.presented(.alert(.confirmDeletion(id: id)))):
                state.habits.remove(id: id)
                return .none

            case .destination:
                return .none

            case let .path(.element(id: id, action: .delegate(.confirmDeletion))):
                guard let detailState = state.path[id: id]
                else { return .none }
                state.habits.remove(id: detailState.habit.id)
                return .none

            case .path:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination) {
            Destination.body
        }
        .forEach(\.path, action: \.path) {
            HabitDetailFeature()
        }
    }
}
extension AllHabitsFeature {
    @Reducer
    enum Destination {
        case addHabit(AddHabitFeature)
        case alert(AlertState<AllHabitsFeature.Action.Alert>)
    }
}

extension AllHabitsFeature.Destination.State: Equatable {}
