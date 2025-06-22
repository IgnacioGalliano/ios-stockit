//
//  LoginUseCase.swift
//  StockIt
//
//  Created by Ignacio Galliano on 27/02/2025.
//

import Foundation

protocol UserUseCase {
    func login(email: String, password: String) async throws -> UserModel
}

struct DefaultUserUseCase: UserUseCase {
    private let repository: UserRepository

    init(repository: UserRepository = DataProvider.shared.userRepository) {
        self.repository =  repository
    }

    func login(email: String, password: String) async throws -> UserModel {
        try await repository.login(email: email, password: password)
    }
}
