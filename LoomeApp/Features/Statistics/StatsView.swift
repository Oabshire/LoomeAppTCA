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
        Text("Statistics Screen")
            .font(.title)
    }
}
