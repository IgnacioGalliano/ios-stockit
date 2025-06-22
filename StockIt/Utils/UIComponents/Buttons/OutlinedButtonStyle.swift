//
//  OutlinedButtonStyle.swift
//  StockIt
//
//  Created by Ignacio Galliano on 28/02/2025.
//

import SwiftUI

struct OutlinedButtonStyle: ButtonStyle {
    var icon: Image?

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if let icon = icon {
                icon
                    .foregroundColor(Color(UIColor.systemGray4))
            }
            configuration.label
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color(UIColor.systemGray4), lineWidth: 2)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.white.opacity(configuration.isPressed ? 0.4 : 0.2)) // Change opacity on press
                )
        )
        .scaleEffect(configuration.isPressed ? 0.98 : 1.0) // Press effect
        .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
