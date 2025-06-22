//
//  ProductRepository.swift
//  StockIt
//
//  Created by Ignacio Galliano on 01/03/2025.
//

import Foundation

protocol ProductRepository {
    func getProducts(reloadList: Bool) async throws -> [ProductModel]
    func getProduct(upc: String) async throws -> ProductModel?
    func createProduct(product: ProductModel) async throws
}

class DefaultProductRepository: ProductRepository {
    private let configNetworkService: ProductNetworkServices
    private let keychainManager: KeychainManagerProtocol
    private var products: [ProductModel] = []

    init(configNetworkService: ProductNetworkServices,
         keychainManager: KeychainManagerProtocol = KeychainManager.shared) {
        self.configNetworkService = configNetworkService
        self.keychainManager = keychainManager
    }

    @discardableResult
    func getProducts(reloadList: Bool) async throws -> [ProductModel] {
        guard products.isEmpty || reloadList else { return products }

        let responseDTO = try await configNetworkService.getProducts()
        let products = responseDTO.data.data.map { product in product.toModel() }
        self.products = products

        return products
    }

    func createProduct(product: ProductModel) async throws {
        try await configNetworkService.createProduct(product: product.toDTO())
    }

    func getProduct(upc: String) async throws -> ProductModel? {
        try await getProducts(reloadList: false)

        return products.first { $0.upc == upc }
    }
}
