//
//  SettingsView.swift
//  StockIt
//
//  Created by Ignacio Galliano on 22/06/2025.
//

import SwiftUI

struct SettingsView<SettingsViewModel>: View where SettingsViewModel: SettingsViewModelable {
    @ObservedObject var viewModel: SettingsViewModel
    @EnvironmentObject var coordinator: StockItCoordinator

    var body: some View {
        VStack() {
            TextField("", text: $viewModel.baseURL,
                      prompt: Text("Base URL").foregroundColor(Color(UIColor.systemGray4)))
                .textFieldStyle(OutlinedTextFieldStyle())
                .padding(.horizontal, 30)
            Button(action: {
                viewModel.saveButtonTapped()
            }) {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
            }
            .buttonStyle(OutlinedButtonStyle())
            .padding([.horizontal, .top], 30)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}
