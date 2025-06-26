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
    case cancelButtonTapped
    case saveButtonTapped
    case setName(String)
  }
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .cancelButtonTapped:
        return .none

      case .saveButtonTapped:
        return .none

      case let .setName(name):
        state.habit.name = name
        return .none
      }
    }
  }
}
