//
//  ProductsUseCases.swift
//  StockIt
//
//  Created by Ignacio Galliano on 01/03/2025.
//

import Foundation

protocol ProductsUseCases {
    func getProducts(reloadList: Bool) async throws -> [ProductModel]
    func getProduct(upc: String) async throws -> ProductModel?
    func createProduct(product: ProductModel) async throws
}

struct DefaultProductsUseCases: ProductsUseCases {
    private let repository: ProductRepository

    init(repository: ProductRepository = DataProvider.shared.productRepository) {
        self.repository =  repository
    }

    func getProducts(reloadList: Bool) async throws -> [ProductModel] {
        try await repository.getProducts(reloadList: reloadList)
    }

    func getProduct(upc: String) async throws -> ProductModel? {
        try await repository.getProduct(upc: upc)
    }

    func createProduct(product: ProductModel) async throws {
        try await repository.createProduct(product: product)
    }
}
