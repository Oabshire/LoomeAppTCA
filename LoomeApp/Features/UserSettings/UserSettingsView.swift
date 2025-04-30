//
//  UserSettingsView.swift
//  LoomeApp
//
//  Created by Onie on 4/30/25.
//

import SwiftUI
import ComposableArchitecture

struct UserSettingsView: View {
    let store: StoreOf<UserSettings>

    var body: some View {
        NavigationStack {
            Text("User Settings")
                .navigationTitle("Settings")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Close") {
                            store.send(.closeButtonTapped)
                        }
                    }
                }
        }
    }
}
