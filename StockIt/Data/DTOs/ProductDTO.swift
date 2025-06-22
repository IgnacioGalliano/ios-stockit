//
//  ProductDTO.swift
//  StockIt
//
//  Created by Ignacio Galliano on 01/03/2025.
//

import Foundation

struct ProductDTO: Codable {
    let _id: String
    let name: String
    let upc: String
    let description: String
    let photo: String
    let quantity: Int

    func toModel() -> ProductModel {
        return ProductModel(id: _id,
                            name: name,
                            upc: upc,
                            description: description,
                            photo: photo,
                            quantity: quantity)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(upc, forKey: .upc)
        try container.encode(description, forKey: .description)
        try container.encode(photo, forKey: .photo)
        try container.encode(quantity, forKey: .quantity)
    }
}
