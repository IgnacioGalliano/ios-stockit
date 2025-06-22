//
//  ProductListViewModel.swift
//  StockIt
//
//  Created by Ignacio Galliano on 27/02/2025.
//

import Foundation

protocol ProductListViewModelable: AnyObject, ObservableObject {
    var productList: [ProductModel] { get }
    var showLoading: Bool { get }
    var getQuantityOfProducts: Int { get }

    func loadProducts()
    func profileTapped()
    func addProductTapped()
    func productTapped(product: ProductModel)
}

class ProductListViewModel: ObservableObject, @preconcurrency ProductListViewModelable {
    @Published var productList: [ProductModel] = []
    @Published var showLoading: Bool = false
    private let productsUseCases: ProductsUseCases
    private let coordinator: StockItCoordinator?
    private let reloadList: Bool

    var getQuantityOfProducts: Int {
        return productList.count
    }

    init(productsUseCases: ProductsUseCases = DefaultProductsUseCases(),
         coordinator: StockItCoordinator,
         parameters: [String: Any]) {
        self.productsUseCases = productsUseCases
        self.coordinator = coordinator
        reloadList = parameters["reloadList"] as? Bool ?? false
    }

    @MainActor
    func loadProducts() {
        Task{
            showLoading = true
            do {
                let productList = try await productsUseCases.getProducts(reloadList: reloadList)
                showLoading = false
                self.productList = productList
            } catch let error {
                showLoading = false
//            Create error view
            }
        }
    }

    func profileTapped() {
        coordinator?.open(page: .profile, isRoot: false)
    }

    func addProductTapped() {
        coordinator?.open(page: .scanner, isRoot: false)
    }

    func productTapped(product: ProductModel) {
        coordinator?.open(page: .transaction, isRoot: false, parameters: ["Product" : product])
    }
}
