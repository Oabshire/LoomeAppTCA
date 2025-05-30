//
//  UserSettingsView.swift
//  LoomeApp
//
//  Created by Onie on 4/30/25.
//

import SwiftUI
import ComposableArchitecture


struct UserSettingsView: View {
    let store: StoreOf<UserSettings>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 20) {
                Text("Theme Settings")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Choose Theme")
                        .font(.headline)

                    ForEach(ThemeMode.allCases) { mode in
                        ThemeOptionRow(
                            mode: mode,
                            isSelected: viewStore.themeMode == mode
                        ) {
                            print("SELECTED \(mode)")
                            viewStore.send(.themeModeChanged(mode))
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                Spacer()
            }
            .padding()
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        viewStore.send(.closeButtonTapped)
                    }
                }
            }
            .preferredColorScheme(viewStore.themeMode.colorScheme)
            .onAppear { viewStore.send(.onAppear) }
        }
    }
}
