//
//  MainTabView.swift
//  LoomeApp
//
//  Created by Onie on 4/29/25.
//

import SwiftUI
import ComposableArchitecture

struct MainTabView: View {
    let store: StoreOf<MainTab>

    var body: some View {
        WithViewStore(store, observe: \MainTab.State.self) { viewStore in
            NavigationView {
                VStack {
                    TabView(
                        selection: viewStore.binding(
                            get: \.selectedTab,
                            send: MainTab.Action.tabSelected
                        )
                    ) {
                        HomeView(store: store.scope(state: \.home, action: \.home))
                            .tabItem { Label("Home", systemImage: "house") }
                            .tag(MainTab.Tab.home)

                        AddHabitView(store: store.scope(state: \.addHabit, action: \.addHabit))
                            .tabItem { Label("New", systemImage: "plus.app") }
                            .tag(MainTab.Tab.addHabit)

                        StatsView(store: store.scope(state: \.stats, action: \.stats))
                            .tabItem { Label("Stats", systemImage: "chart.xyaxis.line") }
                            .tag(MainTab.Tab.stats)
                    }

                    // Невидимый NavigationLink для программного перехода
                    NavigationLink(
                        destination: UserSettingsView(
                            store: store.scope(state: \.userSettings, action: \.userSettings)
                        )
                        .navigationBarHidden(false)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Done") {
                                    // Возвращаемся назад через UserSettings action
                                    store.send(.userSettings(.closeButtonTapped))
                                }
                            }
                        },
                        isActive: viewStore.binding(
                            get: \.isSettingsViewPresent,
                            send: { .binding(.set(\.$isSettingsViewPresent, $0)) }
                        )
                    ) {
                        EmptyView()
                    }
                    .hidden()
                }
            }
            .preferredColorScheme(viewStore.themeMode.colorScheme)
            .onAppear { viewStore.send(.onAppear) }
        }
    }
}
