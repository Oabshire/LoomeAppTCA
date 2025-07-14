//
//  HabitDetailView.swift
//  LoomeApp
//
//  Created by Onie on 7/2/25.
//

import ComposableArchitecture
import SwiftUI

struct HabitDetailView: View {
    @Bindable var store: StoreOf<HabitDetailFeature>

    var body: some View {
        Form {
            Button("Delete") {
                store.send(.deleteButtonTapped)
            }
        }
        .navigationTitle(Text(store.habit.title))
        .alert($store.scope(state: \.alert, action: \.alert))

    }
}


#Preview {
    NavigationStack {
        HabitDetailView(
            store: Store(
                initialState: HabitDetailFeature.State(
                    habit: Habit(id: UUID(), title: "Blob")
                )
            ) {
                HabitDetailFeature()
            }
        )
    }
}
