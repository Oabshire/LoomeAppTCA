//
//  MainTabView.swift
//  LoomeApp
//
//  Created by Onie on 4/29/25.
//

import SwiftUI
import ComposableArchitecture

struct MainTabView: View {
    let store: StoreOf<MainTabFeature>

    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                HomeView(store: store.scope(state: \.homeTab, action: \.homeTab))
            }
            Tab("Stats", systemImage: "chart.xyaxis.line") {
                StatsView(store: store.scope(state: \.statsTab, action: \.statsTab))
            }
            Tab("Settings", systemImage: "gearshape") {
                SettingsView(store: store.scope(state: \.settingsTab, action: \.settingsTab))
            }
        }
    }
}

