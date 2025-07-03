//
//  AllHabitsView.swift
//  LoomeApp
//
//  Created by Onie on 7/3/25.
//

import SwiftUI
import ComposableArchitecture

struct AllHabitsView: View {
    @Bindable var store: StoreOf<AllHabitsFeature>

    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            List {
                ForEach(store.habits) { habit in
                    NavigationLink(state: HabitDetailFeature.State(habit: habit)) {
                        Text(habit.title)
                    }
                    .buttonStyle(.borderless)
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
        } destination: { store in
             HabitDetailView(store: store)
           }
        .sheet(
            item: $store.scope(state: \.destination?.addHabit, action: \.destination.addHabit)
        ) { addHabitStore in
            NavigationStack {
                AddHabitView(store: addHabitStore)
            }
        }
    }
}


#Preview {
    AllHabitsView(
        store: Store(
            initialState: AllHabitsFeature.State(
                habits: [
                    Habit(id: UUID(), title: "Exercise"),
                    Habit(id: UUID(), title: "BrushTeeth"),
                    Habit(id: UUID(), title: "DrinkWater"),
                ]
            )
        ) {
            AllHabitsFeature()
        }
    )
}
