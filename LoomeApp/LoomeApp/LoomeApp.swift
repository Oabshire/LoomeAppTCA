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
    var body: some Scene {
        WindowGroup {
            MainTabView(
                store: Store(
                    initialState: MainTab.State()
                ) {
                    MainTab()
                        ._printChanges()
                }
            )
        }
    }
}
