//
//  SplashBuilder.swift
//  StockIt
//
//  Created by Ignacio Galliano on 03/03/2025.
//

import SwiftUI

struct SplashBuilder {
    static func build(coordinator: StockItCoordinator) -> some View {
        let viewModel = SplashViewModel(coordinator: coordinator)
        let view = SplashView(viewModel: viewModel)

        return view
    }
}
