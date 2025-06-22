//
//  ProductListView.swift
//  StockIt
//
//  Created by Ignacio Galliano on 27/02/2025.
//

import SwiftUI

protocol ProductListViewDelegate {
    func rowTapped(product: ProductModel)
}

struct ProductListView<ProductListViewModel>: View where ProductListViewModel: ProductListViewModelable {
    @ObservedObject var viewModel: ProductListViewModel
    @EnvironmentObject var coordinator: StockItCoordinator

    var body: some View {
        ZStack {
            VStack {
                if viewModel.showLoading {
                    LoadingView()
                } else {
                    List(viewModel.productList, id: \..id) { item in
                        ProductRow(product: item, delegate: self)
                            .contentShape(Rectangle())
                            .listRowSeparator(.hidden)
                            .listRowInsets(.init(top: Constants.rowTopInsets,
                                                 leading: Constants.rowSideInsets,
                                                 bottom: Constants.rowBottomInsets,
                                                 trailing: Constants.rowSideInsets))
                            .listRowBackground(Color.white)
                            .accessibilityIdentifier(Constants.productCellIdentifier)
                    }
                    .refreshable {
                        viewModel.loadProducts()
                    }
                    .frame(maxWidth: .infinity)
                    .listStyle(PlainListStyle())
                    .navigationBarTitle(Localizable.productList,
                                        displayMode: .inline)
                    .accessibilityIdentifier(Constants.productsListIdentifier)
                }
            }
            .background(Color.white)
            .onAppear {
                viewModel.loadProducts()
            }
            .navigationBarItems(trailing: Button(action: {
                viewModel.profileTapped()
            }) {
                Image(systemName: "person")
                    .resizable()
                    .padding(4)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .foregroundColor(.black)
            })

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.addProductTapped()
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding()
                }
            }
        }
    }
}

fileprivate struct Constants {
    static let rowSideInsets: CGFloat = 10
    static let rowTopInsets: CGFloat = 10
    static let rowBottomInsets: CGFloat = 10
    static let productsListIdentifier: String = "ProductsList"
    static let productCellIdentifier: String = "ProductCell"
}

// MARK: - Row Delegate
extension ProductListView: ProductListViewDelegate {
    func rowTapped(product: ProductModel) {
        viewModel.productTapped(product: product)
    }
}
