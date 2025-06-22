//
//  StockItCoordinator.swift
//  StockIt
//
//  Created by Ignacio Galliano on 27/02/2025.
//

import SwiftUI

protocol StockItCoordinatable: ObservableObject {
    func popView()
    func showPopUp()
    func open(page: StockItPages, isRoot: Bool, animation: Animation?, parameters: [String: Any])
}

class StockItCoordinator: ObservableObject, StockItCoordinatable {
    @Published var path = NavigationPath()
    @Published var page: StockItPages = .splash
    @Published var sheet: Sheet?
    var parameters: [String: Any] = [:]

    func open(page: StockItPages,
              isRoot: Bool,
              animation: Animation? = .none,
              parameters: [String: Any] = [:]) {
        self.parameters = parameters
        if isRoot {
            withAnimation(animation) {
                self.page = page
                self.path = NavigationPath() // Clear navigation stack
            }
        } else {
            path.append(page)
        }
        DispatchQueue.main.async {
            self.clearParameters()
        }
    }

    func showPopUp() {
        sheet = .popup
    }

    func popView() {
        if !path.isEmpty {
            path.removeLast()
        }
    }

    // MARK: - View provider

    @ViewBuilder
    func getPage(_ newPage: StockItPages) -> some View {
        switch newPage {
        case .splash:
            SplashBuilder.build(coordinator: self).id(newPage)
        case .login:
            LoginViewBuilder.build(coordinator: self).id(newPage)
        case .productList:
            ProductListBuilder.build(coordinator: self, parameters: parameters).id(newPage)
        case .scanner:
            ScannerViewBuilder.build(coordinator: self).id(newPage)
        case .productEdition:
            ProductEditionBuilder.build(coordinator: self, parameters: parameters).id(newPage)
        case .transaction:
            TransactionBuilder.build(coordinator: self, parameters: parameters).id(newPage)
        case .profile:
            ProfileBuilder.build(coordinator: self).id(newPage)
        case .settings:
            SettingsBuilder.build(coordinator: self).id(newPage)
        }
    }

    private func clearParameters() {
        parameters = [:]
    }

    // MARK: - Sheet provider
    @ViewBuilder
    func getSheet(sheet: Sheet) -> some View {
//        switch sheet {
//        case .popup:
////            CharacterListBuilder.build()
//        }
    }
}

enum StockItPages: String, CaseIterable, Identifiable {
    case splash
    case login
    case productList
    case scanner
    case productEdition
    case transaction
    case profile
    case settings

    var id: String { self.rawValue }
}

enum Sheet: String, CaseIterable, Identifiable {
    case popup

    var id: String { self.rawValue }
}
