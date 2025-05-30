//
//  ThemeOptionRow.swift
//  LoomeApp
//
//  Created by Onie on 5/30/25.
//

import SwiftUI
import ComposableArchitecture

// MARK: - Theme Option Row Component
struct ThemeOptionRow: View {
    let mode: ThemeMode
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(iconColor)
                    .frame(width: 24)

                Text(mode.displayName)
                    .foregroundColor(.primary)

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.accentColor)
                        .fontWeight(.semibold)
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? Color.accentColor.opacity(0.1) : Color.clear)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .onTapGesture {
            print("Theme tapped: \(mode)")
            action()
            print("After action called")
        }
    }

    private var iconName: String {
        switch mode {
        case .light: return "sun.max"
        case .dark: return "moon"
        case .system: return "gear"
        }
    }

    private var iconColor: Color {
        switch mode {
        case .light: return .orange
        case .dark: return .purple
        case .system: return .blue
        }
    }
}
