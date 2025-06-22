//
//  TransactionBuilder.swift
//  StockIt
//
//  Created by Ignacio Galliano on 16/03/2025.
//

import SwiftUI

struct TransactionBuilder {
    static func build(coordinator: StockItCoordinator,
                      parameters: [String: Any]) -> some View {
        let viewModel = TransactionViewModel(parameters: parameters, coordinator: coordinator)
        let view = TransactionView(viewModel: viewModel)

        return view
    }
}
