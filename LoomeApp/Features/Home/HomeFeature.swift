//
//  HomeFeature.swift
//  LoomeApp
//
//  Created by Onie on 4/29/25.
//

import Foundation
import ComposableArchitecture


@Reducer
struct HomeFeature {
    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?
        var habits: IdentifiedArrayOf<Habit> = []
    }
    enum Action {
        case addButtonTapped
        case markAsDoneTapped(id: Habit.ID)
        case destination(PresentationAction<Destination.Action>)
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case addHabit(Habit)
            case deleteHabit(Habit.ID)
        }
    }
    
    @Dependency(\.uuid) var uuid
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.destination = .addHabit(
                    AddHabitFeature.State(habit: Habit(id: uuid(), title: ""))
                )
                return .none
                
            case let .destination(.presented(.addHabit(.delegate(.saveHabit(habit))))):
                return .send(.delegate(.addHabit(habit)))
                
            case .markAsDoneTapped(let id):
                if let index = state.habits.firstIndex(where: { $0.id == id }) {
                    let today = Calendar.current.startOfDay(for: Date())
                    state.habits[index].completionHistory.insert(today)
                }
                return .none
                
            case .destination:
                return .none
            case .delegate(_):
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
    }
}

extension HomeFeature.Destination.State: Equatable {}

