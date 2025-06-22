//
//  TransactionViewModel.swift
//  StockIt
//
//  Created by Ignacio Galliano on 16/03/2025.
//

import Foundation

protocol TransactionViewModelable: AnyObject, ObservableObject {
    var showLoading: Bool { get }
    var productName: String { get set }
    var description: String { get set }
    var currentQuantity: String { get set }
    var nextQuantity: String { get set }

    func saveButtonTapped()
}

class TransactionViewModel: ObservableObject, @preconcurrency TransactionViewModelable {
    @Published var showLoading: Bool = false
    @Published var productName: String = ""
    @Published var description: String = ""
    @Published var currentQuantity: String = ""
    @Published var nextQuantity: String = ""
    private var product: ProductModel? = nil
    private let userUseCase: UserUseCase
    private let coordinator: StockItCoordinator?
    private let transactionsUseCases: TransactionsUseCases

    init(transactionsUseCases: TransactionsUseCases = DefaultTransactionsUseCases(),
         userUseCase: UserUseCase = DefaultUserUseCase(),
         parameters: [String: Any],
         coordinator: StockItCoordinator) {
        self.userUseCase = userUseCase
        self.coordinator = coordinator
        self.transactionsUseCases = transactionsUseCases
        if let product = parameters["Product"] as? ProductModel {
            self.product = product
            self.productName = product.name
            self.currentQuantity = String(product.quantity)
        }
    }

    @MainActor
    func saveButtonTapped() {
        Task{
            showLoading = true
            do {
                try await transactionsUseCases.createTransaction(productId: self.product?.id ?? "", quantity: Int(nextQuantity) ?? 0)
                showLoading = false
                coordinator?.open(page: .productList, isRoot: true, parameters: ["reloadList": true])
            } catch let error {
                showLoading = false
//            Create error view
            }
        }
    }
}
