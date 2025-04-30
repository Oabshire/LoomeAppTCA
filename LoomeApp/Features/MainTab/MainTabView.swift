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
        WithViewStore(store, observe: \.selectedTab) { viewStore in
            TabView(
                selection: viewStore.binding(
                    send: MainTab.Action.tabSelected
                ),
                content: {
                    HomeView(
                        store: store.scope(
                            state: \.home,
                            action: \.home
                        )
                    )
                    .tabItem { Label("Home", systemImage: "house") }
                    .tag(MainTab.Tab.home)

                    AddHabitView(
                        store: store.scope(
                            state: \.search,
                            action: \.search
                        )
                    )
                    .tabItem { Label("New", systemImage: "plus.app") }
                    .tag(MainTab.Tab.search)

                    StatsView(
                        store: store.scope(
                            state: \.profile,
                            action: \.profile
                        )
                    )
                    .tabItem { Label("Stats", systemImage: "chart.xyaxis.line") }
                    .tag(MainTab.Tab.profile)
                }
            )
        }
    }
}
