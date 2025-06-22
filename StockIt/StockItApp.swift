//
//  StockItApp.swift
//  StockIt
//
//  Created by Ignacio Galliano on 26/02/2025.
//

import SwiftUI

@main
struct StockItApp: App {
    @StateObject var coordinator = StockItCoordinator()
    var body: some Scene {
        WindowGroup {
            StockItMainPage()
                .environmentObject(coordinator)
        }
    }
}
