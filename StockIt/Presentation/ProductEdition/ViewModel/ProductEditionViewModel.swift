//
//  ProductEditionViewModel.swift
//  StockIt
//
//  Created by Ignacio Galliano on 15/03/2025.
//

import Foundation

protocol ProductEditionViewModelable: AnyObject, ObservableObject {
    var showLoading: Bool { get }
    var productName: String { get set }
    var description: String { get set }
    var url: String { get set }
    var quantity: String { get set }
    var barCode: String { get set }

    func saveButtonTapped()
}

class ProductEditionViewModel: ObservableObject, @preconcurrency ProductEditionViewModelable {
    @Published var showLoading: Bool = false
    @Published var productName: String = ""
    @Published var description: String = ""
    @Published var url: String = ""
    @Published var quantity: String = ""
    @Published var barCode: String = ""
    private let userUseCase: UserUseCase
    private let coordinator: StockItCoordinator?
    private let productsUseCases: ProductsUseCases

    init(productsUseCases: ProductsUseCases = DefaultProductsUseCases(),
         userUseCase: UserUseCase = DefaultUserUseCase(),
         parameters: [String: Any],
         coordinator: StockItCoordinator) {
        self.userUseCase = userUseCase
        self.coordinator = coordinator
        self.productsUseCases = productsUseCases
        if let barCode = parameters["BarCode"] as? String {
            self.barCode = barCode
        }
    }

    @MainActor
    func saveButtonTapped() {
        Task{
            showLoading = true
            do {
                let newProduct = ProductModel(id: nil,
                                              name: productName,
                                              upc: barCode,
                                              description: description,
                                              photo: url,
                                              quantity: Int(quantity) ?? 0)
                try await productsUseCases.createProduct(product: newProduct)
                showLoading = false
                coordinator?.open(page: .productList, isRoot: true, parameters: ["reloadList": true])
            } catch let error {
                showLoading = false
//            Create error view
            }
        }
    }
}
