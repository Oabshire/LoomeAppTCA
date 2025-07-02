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
        @Presents var destination: Destination.State?
        var habits: IdentifiedArrayOf<Habit> = []
    }
    enum Action {
        case addButtonTapped
        case deleteButtonTapped(id: Habit.ID)
        case destination(PresentationAction<Destination.Action>)

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
                        habit: Habit(id: self.uuid(), name: "")
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

            case let .deleteButtonTapped(id: id):
                state.destination = .alert(
                    AlertState {
                        TextState("Are you sure?")
                    } actions: {
                        ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
                            TextState("Delete")
                        }
                    }
                )
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination) {
            Destination.body
        }
    }
}

extension HomeFeature {
    @Reducer
    enum Destination {
        case addHabit(AddHabitFeature)
        case alert(AlertState<HomeFeature.Action.Alert>)
    }
}

extension HomeFeature.Destination.State: Equatable {}
