//
//  TransactionServices.swift
//  StockIt
//
//  Created by Ignacio Galliano on 16/03/2025.
//

import Foundation

protocol TransactionNetworkServices {
    func createTransaction(productId: String, quantity: Int) async throws
}

class DefaultTransactionNetworkServices: BaseServices, TransactionNetworkServices {
    func createTransaction(productId: String, quantity: Int) async throws {
        let productsURL = try URLBuilder.createTransactionsURL()
        
        let dicData: [String: Any] = ["user": userSession.user?.id ?? "",
                                      "product": productId,
                                      "quantity": quantity]
        let jsonData = try JSONSerialization.data(withJSONObject: dicData, options: .prettyPrinted)
        
        let urlSession = URLSession.shared
        var request = URLRequest(url: productsURL)
        request.httpBody = jsonData
        let token = userSession.authToken
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + token!, forHTTPHeaderField: "Authorization")
        let (data, _) = try await urlSession.data(for: request)
        print(String(data: data, encoding: .utf8) ?? "")
    }
}
