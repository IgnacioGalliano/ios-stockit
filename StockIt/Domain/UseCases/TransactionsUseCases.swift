//
//  TransactionsUseCases.swift
//  StockIt
//
//  Created by Ignacio Galliano on 16/03/2025.
//

import Foundation

protocol TransactionsUseCases {
    func createTransaction(productId: String, quantity: Int) async throws
}

struct DefaultTransactionsUseCases: TransactionsUseCases {
    private let transactionService: TransactionNetworkServices

    init(transactionService: TransactionNetworkServices = DefaultTransactionNetworkServices()) {
        self.transactionService =  transactionService
    }

    func createTransaction(productId: String, quantity: Int) async throws {
        try await transactionService.createTransaction(productId: productId, quantity: quantity)
    }
}
