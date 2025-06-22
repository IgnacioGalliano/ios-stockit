//
//  ProductEditionBuilder.swift
//  StockIt
//
//  Created by Ignacio Galliano on 15/03/2025.
//

import SwiftUI

struct ProductEditionBuilder {
    static func build(coordinator: StockItCoordinator,
                      parameters: [String: Any]) -> some View {
        let viewModel = ProductEditionViewModel(parameters: parameters, coordinator: coordinator)
        let view = ProductEditionView(viewModel: viewModel)

        return view
    }
}
