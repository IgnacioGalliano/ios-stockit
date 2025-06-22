//
//  DataProvider.swift
//  StockIt
//
//  Created by Ignacio Galliano on 27/02/2025.
//

import Foundation

class DataProvider {
    static let shared = DataProvider()

    private init() {}

    lazy var userRepository: UserRepository = {
        return DefaultUserRepository(configNetworkService: DefaultAuthNetworkServices())
    }()

    lazy var productRepository: ProductRepository = {
        return DefaultProductRepository(configNetworkService: DefaultProductNetworkServices())
    }()
}
