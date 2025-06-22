//
//  AuthServices.swift
//  StockIt
//
//  Created by Ignacio Galliano on 27/02/2025.
//

import Foundation

protocol AuthNetworkServices {
    func login(email: String, password: String) async throws -> LoginResponseDTO
}

class DefaultAuthNetworkServices: AuthNetworkServices {
    func login(email: String, password: String) async throws -> LoginResponseDTO {
        let loginURL = try URLBuilder.createloginURL()
        let requestBody: [String: String] = [
            "email": email,
            "password": password
        ]

        let urlSession = URLSession.shared
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        let (data, _) = try await urlSession.data(for: request)
        let user = try JSONDecoder().decode(LoginResponseDTO.self, from: data)

        return user
    }
}
