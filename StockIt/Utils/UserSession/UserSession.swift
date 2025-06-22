//
//  UserSession.swift
//  StockIt
//
//  Created by Ignacio Galliano on 03/03/2025.
//

import Foundation

protocol UserSessionProtocol {
    var isUserLoggedIn: Bool { get }
    var authToken: String? { get }
    var baseURL: String? { get }
    var user: UserModel? { get }

    func saveUserBaseURL(baseURL: String)
    func saveUserData(user: UserModel)
    func saveToken(token: String)
    func logout()
}

class UserSession: UserSessionProtocol {
    static let shared = UserSession()

    private let keychainManager: KeychainManagerProtocol
    var user: UserModel?

    private init(keychainManager: KeychainManagerProtocol = KeychainManager.shared) {
        self.keychainManager = keychainManager
    }

    var isUserLoggedIn: Bool {
        if user == nil {
            restoreUserData()
        }
        return user != nil
    }

    var authToken: String? {
        keychainManager.getToken()
    }

    var baseURL: String? {
        UserDefaults.standard.string(forKey: "baseURL")
    }

    func saveToken(token: String) {
        keychainManager.saveToken(token)
    }
    
    func saveUserData(user: UserModel) {
        let defaults = UserDefaults.standard
        if let encodedData = try? JSONEncoder().encode(user) {
            defaults.set(encodedData, forKey: "userModel")
        }
    }

    func saveUserBaseURL(baseURL: String) {
        UserDefaults.standard.set(baseURL, forKey: "baseURL")
    }

    func logout() {
        user = nil
        keychainManager.deleteToken()
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "userModel")
    }

    private func restoreUserData() {
        let defaults = UserDefaults.standard
        if let userData = defaults.object(forKey: "userModel") as? Data {
            if let savedUser = try? JSONDecoder().decode(UserModel.self, from: userData) {
                self.user = savedUser
            }
        }
    }
}
