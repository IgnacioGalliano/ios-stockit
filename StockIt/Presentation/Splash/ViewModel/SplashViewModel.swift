//
//  SplashViewModel.swift
//  StockIt
//
//  Created by Ignacio Galliano on 03/03/2025.
//

import Foundation

protocol SplashViewModelable: AnyObject, ObservableObject {
    func openAppFlow()
}

class SplashViewModel: SplashViewModelable {
    private let userSession: UserSessionProtocol
    private let coordinator: StockItCoordinator?

    init(userSession: UserSessionProtocol = UserSession.shared,
         coordinator: StockItCoordinator) {
        self.userSession = userSession
        self.coordinator = coordinator
    }

    func openAppFlow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            if self.userSession.isUserLoggedIn {
                self.coordinator?.open(page: .productList, isRoot: true)
            } else {
                self.coordinator?.open(page: .login, isRoot: true)
            }
        })
    }
}
