//
//  StatsFeature.swift
//  LoomeApp
//
//  Created by Onie on 4/29/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct StatsFeature {
    struct State: Equatable {}

    enum Action {
    }

    var body: some Reducer<State, Action> {
        EmptyReducer()
    }
}
