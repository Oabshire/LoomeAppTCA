//
//  AddHabitView.swift
//  LoomeApp
//
//  Created by Onie on 4/29/25.
//

import SwiftUI
import ComposableArchitecture

struct AddHabitView: View {
    let store: StoreOf<AddHabit>

    var body: some View {
        NavigationStack {
            Text("Add Habit Screen")
                .navigationTitle("New Habit")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            store.send(.settingsButtonTapped)
                        } label: {
                            Image(systemName: "gearshape")
                        }
                    }
                }
        }
    }
}
