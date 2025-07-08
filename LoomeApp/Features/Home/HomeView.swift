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
                    HStack {
                        Text(habit.title)
                        Spacer()
                        Button(action: {
                            store.send(.markAsDoneTapped(id: habit.id))
                        }) {
                            Image(systemName: habit.isCompletedToday ? "checkmark.circle.fill" : "circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(habit.isCompletedToday ? .green : .gray)
                        }
                    }
                }
            }
            .navigationTitle("Today")
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
            item: $store.scope(state: \.destination?.addHabit, action: \.destination.addHabit)
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
                    Habit(id: UUID(), title: "Exercise"),
                    Habit(id: UUID(), title: "BrushTeeth"),
                    Habit(id: UUID(), title: "DrinkWater"),
                ]
            )
        ) {
            HomeFeature()
        }
    )
}
