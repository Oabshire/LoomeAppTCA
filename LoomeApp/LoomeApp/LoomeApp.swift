//
//  LoomeApp.swift
//  LoomeApp
//
//  Created by Onie on 4/29/25.
//

import ComposableArchitecture
import SwiftUI

@main
struct LoomeApp: App {
    static let store = Store(initialState: MainTabFeature.State()) {
        MainTabFeature()
          ._printChanges()
      }

    var body: some Scene {
        WindowGroup {
            MainTabView(
                store: LoomeApp.store)
        }
    }
}

