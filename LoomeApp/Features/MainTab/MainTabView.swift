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
        WithViewStore(self.store, observe: \.selectedTab) { viewStore in
            TabView(selection: viewStore.binding(
                get: { $0 },
                send: MainTabFeature.Action.selectedTabChanged
            )) {
                Tab("Home", systemImage: "house", value: .home) {
                    HomeView(store: store.scope(state: \.homeTab, action: \.homeTab))
                }
                Tab("Habits", systemImage: "list.bullet", value: .habits) {
                    AllHabitsView(store: store.scope(state: \.allHabitsTab, action: \.allHabitsTab))
                }
                Tab("Stats", systemImage: "chart.xyaxis.line", value: .stats) {
                    StatsView(store: store.scope(state: \.statsTab, action: \.statsTab))
                }
                Tab("Settings", systemImage: "gearshape", value: .settings) {
                    SettingsView(store: store.scope(state: \.settingsTab, action: \.settingsTab))
                }
                Tab("NewHabit", systemImage: "plus", value: .addHabit, role: .search) {
                    AddHabitView(store: store.scope(state: \.addHabitTab, action: \.addHabitTab))
                }
            }
            .onAppear {
                viewStore.send(.onApear)
            }
        }
    }
}
