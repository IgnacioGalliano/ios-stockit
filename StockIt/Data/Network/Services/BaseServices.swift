//
//  BaseServices.swift
//  StockIt
//
//  Created by Ignacio Galliano on 01/03/2025.
//

class BaseServices {
    internal let userSession: UserSessionProtocol

    init(userSession: UserSessionProtocol = UserSession.shared) {
        self.userSession = userSession
    }
}
