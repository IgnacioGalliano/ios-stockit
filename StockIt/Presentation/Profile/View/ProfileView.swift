//
//  ProfileView.swift
//  StockIt
//
//  Created by Ignacio Galliano on 22/06/2025.
//

import SwiftUI

protocol ProfileViewDelegate {}

struct ProfileView<ProfileViewModel>: View where ProfileViewModel: ProfileViewModelable {
    @ObservedObject var viewModel: ProfileViewModel
    @EnvironmentObject var coordinator: StockItCoordinator

    var body: some View {
        VStack() {
            VStack {
                Button(action: {
                    viewModel.settingsButtonTapped()
                }) {
                    Text("Settings")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color(UIColor.white))
                }
                .buttonStyle(OutlinedButtonStyle())
                .padding([.horizontal, .top], 30)
                Button(action: {
                    viewModel.logoutButtonTapped()
                }) {
                    Text("Logout")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color(UIColor.white))
                }
                .buttonStyle(OutlinedButtonStyle())
                .padding([.horizontal, .top], 30)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            Rectangle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color(hex: "0f6865"), Color(hex: "092933")]),
                                   startPoint: .top,
                                   endPoint: .bottom))
                .ignoresSafeArea()
        }
    }
}

extension ProfileView: ProfileViewDelegate {}

fileprivate struct Constants {
    static let rowSideInsets: CGFloat = 10
    static let rowTopInsets: CGFloat = 10
    static let rowBottomInsets: CGFloat = 10
    static let characterListIdentifier: String = "CharacterList"
    static let characterCellIdentifier: String = "CharacterCell"
}
