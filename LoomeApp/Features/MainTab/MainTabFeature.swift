//
//  MainTabFeature.swift
//  LoomeApp
//
//  Created by Onie on 6/17/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MainTabFeature {
    struct State {
        var homeTab = HomeFeature.State()
        var statsTab = StatsFeature.State()
        var settingsTab = SettingsFeature.State()
    }

    enum Action {
        case homeTab(HomeFeature.Action)
        case statsTab(StatsFeature.Action)
        case settingsTab(SettingsFeature.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.homeTab, action: \.homeTab) {
            HomeFeature()
        }
        Scope(state: \.statsTab,action: \.statsTab) {
            StatsFeature()
        }
        Scope(state: \.settingsTab, action: \.settingsTab) {
            SettingsFeature()
        }
        Reduce { state, action in
            // Core logic of the app feature
            return .none
        }
    }
}
