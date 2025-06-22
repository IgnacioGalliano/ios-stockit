//
//  ProfileViewModel.swift
//  StockIt
//
//  Created by Ignacio Galliano on 22/06/2025.
//

import Foundation

protocol ProfileViewModelable: AnyObject, ObservableObject {
    func logoutButtonTapped()
    func settingsButtonTapped()
}

class ProfileViewModel: ObservableObject, @preconcurrency ProfileViewModelable {
    private let userUseCase: UserUseCase
    var view: ProfileViewDelegate?
    private let userSession: UserSessionProtocol
    private let coordinator: StockItCoordinator?

    init(userUseCase: UserUseCase = DefaultUserUseCase(),
         userSession: UserSessionProtocol = UserSession.shared,
         coordinator: StockItCoordinator) {
        self.userUseCase = userUseCase
        self.coordinator = coordinator
        self.userSession = userSession
    }

    @MainActor
    func logoutButtonTapped() {
        userSession.logout()
        coordinator?.open(page: .login, isRoot: true)
    }

    @MainActor
    func settingsButtonTapped() {
        coordinator?.open(page: .settings, isRoot: false)
    }
}
