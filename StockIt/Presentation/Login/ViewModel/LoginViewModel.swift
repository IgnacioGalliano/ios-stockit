//
//  LoginViewModel.swift
//  StockIt
//
//  Created by Ignacio Galliano on 27/02/2025.
//

import Foundation

protocol LoginViewModelable: AnyObject, ObservableObject {
    var showLoading: Bool { get }
    var email: String { get set }
    var password: String { get set }

    func login()
    func settingsButtonTapped()
}

class LoginViewModel: ObservableObject, @preconcurrency LoginViewModelable {
    @Published var showLoading: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    private let userUseCase: UserUseCase
    var view: LoginViewDelegate?
    private let coordinator: StockItCoordinator?

    init(userUseCase: UserUseCase = DefaultUserUseCase(),
         coordinator: StockItCoordinator) {
        self.userUseCase = userUseCase
        self.coordinator = coordinator
    }

    @MainActor
    func login() {
        Task{
            showLoading = true
            do {
                let _ = try await userUseCase.login(email: email, password: password)
                showLoading = false
                coordinator?.open(page: .productList, isRoot: true)
            } catch let error {
                showLoading = false
//            Create error view
            }
        }
    }

    @MainActor
    func settingsButtonTapped() {
        coordinator?.open(page: .settings, isRoot: false)
    }
}
