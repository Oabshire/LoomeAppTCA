//
//  SettingsView.swift
//  LoomeApp
//
//  Created by Onie on 6/23/25.
//

import SwiftUI
import ComposableArchitecture

struct SettingsView: View {
    @Bindable var store: StoreOf<SettingsFeature>

    var body: some View {
        NavigationStack {
        Text("Settings")
            .navigationTitle("Settings")
        }
    }
}
