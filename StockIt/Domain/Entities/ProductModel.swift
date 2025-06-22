//
//  ProductModel.swift
//  StockIt
//
//  Created by Ignacio Galliano on 01/03/2025.
//

import Foundation

struct ProductModel {
    let id: String?
    let name: String
    let upc: String
    let description: String
    let photo: String
    let quantity: Int

    func toDTO() -> ProductDTO {
        ProductDTO(_id: id ?? "",
                   name: name,
                   upc: upc,
                   description: description,
                   photo: photo,
                   quantity: quantity)
    }
}
