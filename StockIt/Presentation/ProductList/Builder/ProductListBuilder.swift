//
//  LoginViewBuilder.swift
//  StockIt
//
//  Created by Ignacio Galliano on 27/02/2025.
//

import SwiftUI

struct ProductListBuilder {
    static func build(coordinator: StockItCoordinator,
                      parameters: [String: Any]) -> some View {
        let viewModel = ProductListViewModel(coordinator: coordinator, parameters: parameters)
        let view = ProductListView(viewModel: viewModel)

        return view
    }
}
