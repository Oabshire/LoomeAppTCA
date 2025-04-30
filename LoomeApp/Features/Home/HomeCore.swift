//
//  HomeCore.swift
//  LoomeApp
//
//  Created by Onie on 4/29/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct Home {
    struct State: Equatable {}

    enum Action {
        case settingsButtonTapped
    }

    var body: some Reducer<State, Action> {
        EmptyReducer()
    }
}
