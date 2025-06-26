//
//  AppearenceSettingsView.swift
//  LoomeApp
//
//  Created by Onie on 6/24/25.
//

import SwiftUI
import ComposableArchitecture

struct AppearenceSettingsView: View {
    @Bindable var store: StoreOf<AppearenceSettingsFeature>

    var body: some View {
        NavigationStack {
        Text("AppearenceSettings")
            .navigationTitle("AppearenceSettings")
        }
    }
}
