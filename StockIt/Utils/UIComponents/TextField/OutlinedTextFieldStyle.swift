//
//  OutlinedTextFieldStyle.swift
//  StockIt
//
//  Created by Ignacio Galliano on 28/02/2025.
//

import SwiftUI

struct OutlinedTextFieldStyle: TextFieldStyle {
    @State var icon: Image?
    var textColor: Color = .black
    var placeholderColor: Color = Color(UIColor.systemGray4)
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            if icon != nil {
                icon
                    .foregroundColor(Color(UIColor.white))
            }
            configuration
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color(UIColor.systemGray4), lineWidth: 2)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous) // Ensure background covers the same shape
                        .fill(Color(UIColor.white).opacity(0.2)) // Apply correct transparency
                )
                .allowsHitTesting(false)
        }
        .foregroundColor(textColor)
    }
}
