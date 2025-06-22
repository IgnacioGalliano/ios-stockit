//
//  GetProductsResponseDTO.swift
//  StockIt
//
//  Created by Ignacio Galliano on 01/03/2025.
//

import Foundation

struct GetProductsResponseDTO: Decodable {
    let status: String
    let results: Int
    let data: GetProductsResponseDataDTO
}

struct GetProductsResponseDataDTO: Decodable {
    let data: [ProductDTO]
}
