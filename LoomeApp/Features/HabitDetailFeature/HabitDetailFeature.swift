//
//  HabitDetailFeature.swift
//  LoomeApp
//
//  Created by Onie on 7/2/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct HabitDetailFeature {
    @ObservableState
    struct State: Equatable {
        @Presents var alert: AlertState<Action.Alert>?
        let habit: Habit
    }

    enum Action {
        case alert(PresentationAction<Alert>)
        case delegate(Delegate)
        case deleteButtonTapped
        enum Alert {
            case confirmDeletion
        }
        enum Delegate {
            case confirmDeletion
        }
    }
    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .alert(.presented(.confirmDeletion)):
                return .run { send in
                    await send(.delegate(.confirmDeletion))
                    await self.dismiss()
                }
            case .alert:
                return .none

            case .delegate:
                return .none

            case .deleteButtonTapped:
                state.alert = .confirmDeletion
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}

extension AlertState where Action == HabitDetailFeature.Action.Alert {
  static let confirmDeletion = Self {
    TextState("Are you sure?")
  } actions: {
    ButtonState(role: .destructive, action: .confirmDeletion) {
      TextState("Delete")
    }
  }
}
