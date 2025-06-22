//
//  LoginResponseDTO.swift
//  StockIt
//
//  Created by Ignacio Galliano on 27/02/2025.
//

import Foundation

struct LoginResponseDTO: Decodable {
    let status: String
    let token: String
    let data: LoginDataDTO
}

struct LoginDataDTO: Decodable {
    let user: UserDTO
}
