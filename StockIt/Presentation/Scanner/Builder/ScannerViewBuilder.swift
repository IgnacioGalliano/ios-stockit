//
//  ScannerViewBuilder.swift
//  StockIt
//
//  Created by Ignacio Galliano on 07/03/2025.
//

import SwiftUI

struct ScannerViewBuilder {
    static func build(coordinator: StockItCoordinator) -> some View {
        let viewModel = BarcodeScannerViewModel(coordinator: coordinator)
        let view = BarcodeScannerContainerView(viewModel: viewModel)

        return view
    }
}
