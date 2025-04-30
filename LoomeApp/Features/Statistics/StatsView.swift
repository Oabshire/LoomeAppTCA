//
//  StatsView.swift
//  LoomeApp
//
//  Created by Onie on 4/29/25.
//

import SwiftUI
import ComposableArchitecture

struct StatsView: View {
    let store: StoreOf<Stats>

    var body: some View {
        NavigationStack {
            Text("Statistics Screen")
                .navigationTitle("Analytics")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            store.send(.settingsButtonTapped)
                        } label: {
                            Image(systemName: "gearshape")
                        }
                    }
                }
        }
    }
}
