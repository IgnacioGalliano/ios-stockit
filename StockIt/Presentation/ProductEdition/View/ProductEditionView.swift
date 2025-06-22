//
//  ProductEditionView.swift
//  StockIt
//
//  Created by Ignacio Galliano on 15/03/2025.
//

import SwiftUI

struct ProductEditionView<ProductEditionViewModel>: View where ProductEditionViewModel: ProductEditionViewModelable {
    @ObservedObject var viewModel: ProductEditionViewModel
    @EnvironmentObject var coordinator: StockItCoordinator

    var body: some View {
        VStack() {
            if viewModel.showLoading {
                LoadingView()
            } else {
                VStack {
                    TextField("", text: $viewModel.productName, prompt: Text("Product").foregroundColor(Color(UIColor.systemGray4)))
                        .textFieldStyle(OutlinedTextFieldStyle())
                        .padding(.horizontal, 30)
                    TextField("", text: $viewModel.description, prompt: Text("Description").foregroundColor(Color(UIColor.systemGray4)))
                        .textFieldStyle(OutlinedTextFieldStyle())
                        .padding(.horizontal, 30)
                        .autocapitalization(.none)
                    TextField("", text: $viewModel.url, prompt: Text("URL Photo").foregroundColor(Color(UIColor.systemGray4)))
                        .textFieldStyle(OutlinedTextFieldStyle())
                        .padding(.horizontal, 30)
                        .autocapitalization(.none)
                    TextField("", text: $viewModel.quantity, prompt: Text("Quantity").foregroundColor(Color(UIColor.systemGray4)))
                        .textFieldStyle(OutlinedTextFieldStyle())
                        .padding(.horizontal, 30)
                        .autocapitalization(.none)
                        .keyboardType(.numberPad)
                    TextField("", text: $viewModel.barCode, prompt: Text("Bar Code").foregroundColor(Color(UIColor.systemGray4)))
                        .textFieldStyle(OutlinedTextFieldStyle())
                        .padding(.horizontal, 30)
                        .autocapitalization(.none)
                        .keyboardType(.numberPad)
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
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}
