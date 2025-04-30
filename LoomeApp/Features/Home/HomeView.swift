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
        Text("Home Screen")
            .font(.title)
    }
}
