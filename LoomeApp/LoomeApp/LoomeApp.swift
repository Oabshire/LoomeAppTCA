//
//  LoomeApp.swift
//  LoomeApp
//
//  Created by Onie on 4/29/25.
//

import ComposableArchitecture
import SwiftData
import SwiftUI

@main
struct LoomeApp: App {
    static let store = Store(initialState: MainTabFeature.State()) {
        MainTabFeature()
          ._printChanges()
      }

    @Dependency(\.databaseService) var databaseService
    var modelContext: ModelContext {
        guard let modelContext = try? self.databaseService.context() else {
            fatalError("Could not find modelcontext")
        }
        return modelContext
    }


    var body: some Scene {
        WindowGroup {
            MainTabView(
                store: LoomeApp.store
            )
            .modelContext(self.modelContext)
        }
    }
}

