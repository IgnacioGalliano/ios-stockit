//
//  TransactionView.swift
//  StockIt
//
//  Created by Ignacio Galliano on 16/03/2025.
//

import SwiftUI

struct TransactionView<TransactionViewModel>: View where TransactionViewModel: TransactionViewModelable {
    @ObservedObject var viewModel: TransactionViewModel
    @EnvironmentObject var coordinator: StockItCoordinator

    var body: some View {
        VStack() {
            if viewModel.showLoading {
                LoadingView()
            } else {
                VStack {
                    Text(viewModel.productName).foregroundColor(Color(UIColor.systemGray4))
                    Text(viewModel.description).foregroundColor(Color(UIColor.systemGray4))
                    TextField("", text: $viewModel.currentQuantity, prompt: Text("Current Quantity").foregroundColor(Color(UIColor.systemGray4)))
                        .textFieldStyle(OutlinedTextFieldStyle())
                        .padding(.horizontal, 30)
                        .keyboardType(.numberPad)
                        .disabled(true)
                    TextField("", text: $viewModel.nextQuantity, prompt: Text("Next Quantity").foregroundColor(Color(UIColor.systemGray4)))
                        .textFieldStyle(OutlinedTextFieldStyle())
                        .padding(.horizontal, 30)
                        .keyboardType(.numberPad)
                        .autocapitalization(.none)
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
