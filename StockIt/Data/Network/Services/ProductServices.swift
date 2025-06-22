//
//  ProductServices.swift
//  StockIt
//
//  Created by Ignacio Galliano on 01/03/2025.
//

import Foundation

protocol ProductNetworkServices {
    func getProducts() async throws -> GetProductsResponseDTO
    func createProduct(product: ProductDTO) async throws
}

class DefaultProductNetworkServices: BaseServices, ProductNetworkServices {
    func getProducts() async throws -> GetProductsResponseDTO {
        let getProductsURL = try URLBuilder.createProductsURL()

        let urlSession = URLSession.shared
        var request = URLRequest(url: getProductsURL)
        let token = userSession.authToken
        request.httpMethod = "GET"
        request.setValue("Bearer " + token!, forHTTPHeaderField: "Authorization")
        let (data, _) = try await urlSession.data(for: request)
        let products = try JSONDecoder().decode(GetProductsResponseDTO.self, from: data)
        return products
    }

    func createProduct(product: ProductDTO) async throws {
        let productsURL = try URLBuilder.createProductsURL()

        let jsonData = try JSONEncoder().encode(product)

        let urlSession = URLSession.shared
        var request = URLRequest(url: productsURL)
        request.httpBody = jsonData
        let token = userSession.authToken
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + token!, forHTTPHeaderField: "Authorization")
        let (data, _) = try await urlSession.data(for: request)
    }
}
