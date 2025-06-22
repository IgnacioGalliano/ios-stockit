//
//  LoginViewBuilder.swift
//  StockIt
//
//  Created by Ignacio Galliano on 27/02/2025.
//

import SwiftUI

struct LoginViewBuilder {
    static func build(coordinator: StockItCoordinator) -> some View {
        let viewModel = LoginViewModel(coordinator: coordinator)
        let view = LoginView(viewModel: viewModel)
        viewModel.view = view

        return view
    }
}
