//
//  KeychainManager.swift
//  StockIt
//
//  Created by Ignacio Galliano on 28/02/2025.
//

import Security
import Foundation

protocol KeychainManagerProtocol {
    @discardableResult
    func saveToken(_ token: String) -> Bool
    @discardableResult
    func deleteToken() -> Bool
    func getToken() -> String?
}

class KeychainManager: KeychainManagerProtocol {
    static let shared = KeychainManager()
    private let account = "userToken"

    private init() {}

    @discardableResult
    /// Save token to Keychain
    func saveToken(_ token: String) -> Bool {
        guard let tokenData = token.data(using: .utf8) else { return false }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecValueData as String: tokenData
        ]

        // Delete existing token before saving a new one
        SecItemDelete(query as CFDictionary)

        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }

    /// Retrieve token from Keychain
    func getToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        guard status == errSecSuccess, let retrievedData = dataTypeRef as? Data else {
            return nil
        }

        return String(data: retrievedData, encoding: .utf8)
    }

    /// Delete token from Keychain
    func deleteToken() -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account
        ]

        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}
