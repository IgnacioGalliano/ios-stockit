//
//  UserModel.swift
//  StockIt
//
//  Created by Ignacio Galliano on 27/02/2025.
//

import Foundation

struct UserModel: Codable {
    let id: String
    let name: String
    let email: String?
    let role: UserRoleModel?

    func getEncodedData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func decode(from data: Data) throws -> UserModel {
        return try JSONDecoder().decode(UserModel.self, from: data)
    }
}

enum UserRoleModel: String, Codable {
    case user
    case admin
}
