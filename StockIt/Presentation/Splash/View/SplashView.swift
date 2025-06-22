//
//  SplashView.swift
//  StockIt
//
//  Created by Ignacio Galliano on 03/03/2025.
//

import SwiftUI

struct SplashView<SplashViewModel>: View where SplashViewModel: SplashViewModelable {
    @ObservedObject var viewModel: SplashViewModel

    var body: some View {
        VStack {
            Text("StockIt")
                .font(.system(size: 40, weight: .bold, design: .default))
                .foregroundColor(.blue)
        }
        .onAppear {
            viewModel.openAppFlow()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Rectangle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color(hex: "0f6865"), Color(hex: "092933")]),
                                   startPoint: .top,
                                   endPoint: .bottom)
                )
                .ignoresSafeArea()
        }
    }
}

fileprivate struct Constants {
    static let rowSideInsets: CGFloat = 10
    static let rowTopInsets: CGFloat = 10
    static let rowBottomInsets: CGFloat = 10
    static let productsListIdentifier: String = "ProductsList"
    static let productCellIdentifier: String = "ProductCell"
}
