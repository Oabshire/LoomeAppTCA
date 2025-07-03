//
//  AddHabitView.swift
//  LoomeApp
//
//  Created by Onie on 4/29/25.
//

import SwiftUI
import ComposableArchitecture

struct AddHabitView: View {
    @Bindable var store: StoreOf<AddHabitFeature>

    var body: some View {
        Form {
            TextField("Name", text: $store.habit.title.sending(\.setName))
            Button("Save") {
                store.send(.saveButtonTapped)
            }
        }
        .toolbar {
            ToolbarItem {
                Button("Cancel") {
                    store.send(.cancelButtonTapped)
                }
            }
        }
    }
}

#Preview {
  NavigationStack {
      AddHabitView(
      store: Store(
        initialState: AddHabitFeature.State(
          habit: Habit(
            id: UUID(),
            title: "Blob"
          )
        )
      ) {
          AddHabitFeature()
      }
    )
  }
}
