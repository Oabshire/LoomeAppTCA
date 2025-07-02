//
//  File.swift
//  LoomeAppTests
//
//  Created by Onie on 7/1/25.
//

import Foundation
import ComposableArchitecture
import Testing


@testable import LoomeApp



@MainActor
struct HomeFeatureTests {
    @Test
    func addFlow() async {
        let store = TestStore(initialState: HomeFeature.State()) {
            HomeFeature()
        } withDependencies: {
            $0.uuid = .incrementing
          }

        await store.send(.addButtonTapped) {
            $0.destination = .addHabit(
                AddHabitFeature.State(
                    habit: Habit(id:  UUID(0), name: "")
                )
            )
        }

        await store.send(\.destination.addHabit.setName, "Drink Water") {
            $0.destination?.modify(\.addHabit) { $0.habit.name = "Drink Water" }
        }

        await store.send(\.destination.addHabit.saveButtonTapped)

        await store.receive(
          \.destination.addHabit.delegate.saveHabit,
          Habit(id: UUID(0), name: "Drink Water")
        ) {
            $0.habits = [
                    Habit(id: UUID(0), name: "Drink Water")
                  ]
        }
        await store.receive(\.destination.dismiss) {
             $0.destination = nil
           }
    }
}
