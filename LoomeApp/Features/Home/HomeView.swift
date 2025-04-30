//
//  HomeView.swift
//  LoomeApp
//
//  Created by Onie on 4/29/25.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    let store: StoreOf<Home>

    var body: some View {
        NavigationStack {
            Text("Home Screen")
                .navigationTitle("Home")
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

