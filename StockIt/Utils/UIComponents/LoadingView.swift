//
//  LoadingView.swift
//  StockIt
//
//  Created by Ignacio Galliano on 27/02/2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .opacity(0.75)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                ProgressView()
                    .tint(.gray)
                Text("Cargando...")
            }
            .foregroundColor(.black)
            .background {
                RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(width: 200, height: 200)
            }
            .offset(y: -70)
        }
    }
}
