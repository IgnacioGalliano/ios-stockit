//
//  UserRepository.swift
//  StockIt
//
//  Created by Ignacio Galliano on 27/02/2025.
//

import Foundation

protocol UserRepository {
    func login(email: String, password: String) async throws -> UserModel
}

class DefaultUserRepository: UserRepository {
    private let configNetworkService: AuthNetworkServices
    private let userSession: UserSessionProtocol

    init(configNetworkService: AuthNetworkServices,
         userSession: UserSessionProtocol = UserSession.shared) {
        self.configNetworkService = configNetworkService
        self.userSession = userSession
    }

    func login(email: String, password: String) async throws -> UserModel {
        let responseDTO = try await configNetworkService.login(email: email, password: password)
        let user = responseDTO.data.user.toModel()
        self.userSession.saveToken(token: responseDTO.token)
        self.userSession.saveUserData(user: user)

        return user
    }
}
