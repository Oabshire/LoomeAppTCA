//
//  UserSettingsCore.swift
//  LoomeApp
//
//  Created by Onie on 4/30/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct UserSettings {
    struct State: Equatable {}

    enum Action {
        case closeButtonTapped
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .closeButtonTapped:
                return .none
            }
        }
    }
}
