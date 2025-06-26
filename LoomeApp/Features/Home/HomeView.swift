//
//  HomeView.swift
//  LoomeApp
//
//  Created by Onie on 4/29/25.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    @Bindable var store: StoreOf<HomeFeature>

    var body: some View {
        NavigationStack {
            List {
                ForEach(store.habits) { habit in
                    Text(habit.name)
                }
            }
            .navigationTitle("Habits")
            .toolbar {
                ToolbarItem {
                    Button {
                        store.send(.addButtonTapped)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(
            item: $store.scope(state: \.addHabit, action: \.addHabit)
        ) { addHabitStore in
            NavigationStack {
                AddHabitView(store: addHabitStore)
            }
        }
    }
}


#Preview {
    HomeView(
        store: Store(
            initialState: HomeFeature.State(
                habits: [
                    Habit(id: UUID(), name: "Exercise"),
                    Habit(id: UUID(), name: "BrushTeeth"),
                    Habit(id: UUID(), name: "DrinkWater"),
                ]
            )
        ) {
            HomeFeature()
        }
    )
}
