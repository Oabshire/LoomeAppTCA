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
        var habits: IdentifiedArrayOf<Habit> = []
    }
    enum Action {
        case markAsDoneTapped(id: Habit.ID)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .markAsDoneTapped(let id):
                if let index = state.habits.firstIndex(where: { $0.id == id }) {
                    let today = Calendar.current.startOfDay(for: Date())
                    state.habits[index].completionHistory.insert(today)
                }
                return .none
            }
        }
    }
}
