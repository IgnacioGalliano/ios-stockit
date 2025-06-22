//
//  SettingsBuilder.swift
//  StockIt
//
//  Created by Ignacio Galliano on 22/06/2025.
//

import SwiftUI

struct SettingsBuilder {
    static func build(coordinator: StockItCoordinator) -> some View {
        let viewModel = SettingsViewModel(coordinator: coordinator)
        let view = SettingsView(viewModel: viewModel)

        return view
    }
}
