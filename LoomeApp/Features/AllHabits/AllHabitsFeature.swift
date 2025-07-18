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
        case destination(PresentationAction<Destination.Action>)
        case path(StackActionOf<HabitDetailFeature>)
        case delegate(Delegate)

        case onApear

        enum Delegate: Equatable {
            case deleteHabit(Habit.ID)
        }
        @CasePathable
        enum Alert: Equatable {
            case confirmDeletion(id: Habit.ID)
        }
    }

    @Dependency(\.uuid) var uuid

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .path(.element(id: id, action: .delegate(.confirmDeletion))):
                guard let detailState = state.path[id: id]
                else { return .none }
                return .send(.delegate(.deleteHabit(detailState.habit.id)))

            case .destination:
                return .none
            case .path:
                return .none
            case .delegate(_):
                return .none

            case .onApear:
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
        case alert(AlertState<AllHabitsFeature.Action.Alert>)
    }
}

extension AllHabitsFeature.Destination.State: Equatable {}
