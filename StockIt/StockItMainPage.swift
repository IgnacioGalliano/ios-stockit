//
//  StockItMainPage.swift
//  StockIt
//
//  Created by Ignacio Galliano on 27/02/2025.
//

import SwiftUI

struct StockItMainPage: View {
    @EnvironmentObject var coordinator: StockItCoordinator
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.getPage(coordinator.page)
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.getSheet(sheet: sheet)
                }
                .navigationDestination(for: StockItPages.self) { page in
                    coordinator.getPage(page)
                }
                .onOpenURL { url in
                    print("Some code for handling")
                }
        }
        .navigationBarTitleTextColor(.black)
    }
}
