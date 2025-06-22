//
//  URLBuilder.swift
//  StockIt
//
//  Created by Ignacio Galliano on 27/02/2025.
//

import Foundation

struct URLBuilder {
    static func createloginURL() throws -> URL {
        return try urlBuilder(url: loginURL)
    }

    static func createProductsURL() throws -> URL {
        return try urlBuilder(url: getProductsURL)
    }

    static func createTransactionsURL() throws -> URL {
        return try urlBuilder(url: getTransactionsURL)
    }

    private static var baseURL: String {
        var baseURL: String
        #if STAGING
        baseURL = Constants.localHost
        #elseif PRODUCTION
        baseURL = Constants.marvelBaseURL
        #elseif DEBUG
        baseURL = Constants.localHost
        #endif
        if let customBaseURL = customBaseURL {
            baseURL = customBaseURL
        }
        return baseURL + Constants.apiPath + Constants.versionPath
    }

    private static var customBaseURL: String? {
        let userSession: UserSessionProtocol = UserSession.shared

        return userSession.baseURL
    }

    private static var loginURL: String {
        baseURL + Constants.usersPath + Constants.loginPath
    }

    private static var getProductsURL: String {
        baseURL + Constants.productsPath
    }

    private static var getTransactionsURL: String {
        baseURL + Constants.transactionsPath
    }

    private static func urlBuilder(url: String, queryItems: [URLQueryItem] = []) throws -> URL {
        guard var urlComponents = URLComponents(string: url) else {
            throw Constants.urlcannotBeFormed
        }

        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            throw Constants.urlcannotBeFormed
        }

        return url
    }

    struct Constants {
        static let email = "email"
        static let password = "password"
        static let apiPath = "/api"
        static let versionPath = "/v1"
        static let usersPath = "/users"
        static let productsPath = "/products"
        static let transactionsPath = "/transactions"
        static let loginPath = "/login"
        static let productionURL = "http://productionURL"
        static let localHost = "http://192.168.1.34:3000"
        static let urlcannotBeFormed: NSError = NSError(domain: "URL CANNOT BE FORMED", code: 400)
    }
}
