//
//  UserDTO.swift
//  StockIt
//
//  Created by Ignacio Galliano on 27/02/2025.
//

import Foundation

struct UserDTO: Decodable {
    let _id: String
    let name: String
    let email: String
    let role: UserRoleDTO

    func toModel() -> UserModel {
        return UserModel(id: _id,
                         name: name,
                         email: email,
                         role: role.toModel())
    }
}

enum UserRoleDTO: String, Codable {
    case user
    case admin

    func toModel() -> UserRoleModel {
        UserRoleModel(rawValue: self.rawValue) ?? .user
    }
}
