//
//  ProfileBuilder.swift
//  StockIt
//
//  Created by Ignacio Galliano on 22/06/2025.
//

import SwiftUI

struct ProfileBuilder {
    static func build(coordinator: StockItCoordinator) -> some View {
        let viewModel = ProfileViewModel(coordinator: coordinator)
        let view = ProfileView(viewModel: viewModel)
        viewModel.view = view

        return view
    }
}
