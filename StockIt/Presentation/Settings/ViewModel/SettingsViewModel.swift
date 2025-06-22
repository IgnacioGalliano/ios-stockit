//
//  SettingsViewModel.swift
//  StockIt
//
//  Created by Ignacio Galliano on 22/06/2025.
//

import Foundation

protocol SettingsViewModelable: AnyObject, ObservableObject {
    var baseURL: String { get set }

    func saveButtonTapped()
}

class SettingsViewModel: ObservableObject, @preconcurrency SettingsViewModelable {
    @Published var baseURL: String = ""
    private let coordinator: StockItCoordinator?
    private let userSession: UserSessionProtocol

    init(userSession: UserSessionProtocol = UserSession.shared,
         coordinator: StockItCoordinator) {
        self.coordinator = coordinator
        self.userSession = userSession
        baseURL = userSession.baseURL ?? ""
    }

    @MainActor
    func saveButtonTapped() {
        userSession.saveUserBaseURL(baseURL: baseURL)
        coordinator?.popView()
    }
}
