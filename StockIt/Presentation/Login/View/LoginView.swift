//
//  LoginView.swift
//  StockIt
//
//  Created by Ignacio Galliano on 27/02/2025.
//

import SwiftUI

protocol LoginViewDelegate {
    func loginButtonTapped()
}

struct LoginView<LoginViewModel>: View where LoginViewModel: LoginViewModelable {
    @ObservedObject var viewModel: LoginViewModel
    @EnvironmentObject var coordinator: StockItCoordinator

    var body: some View {
        VStack() {
            if viewModel.showLoading {
                LoadingView()
            } else {
                VStack {
                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(OutlinedTextFieldStyle(icon: Image(systemName: "person"), textColor: .white))
                        .padding(.horizontal, 30)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(OutlinedTextFieldStyle(icon: Image(systemName: "key.horizontal"), textColor: .white))
                        .padding(.horizontal, 30)
                        .padding(.top, 10)
                    Button(action: {
                        viewModel.login()
                    }) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color(UIColor.white))
                    }
                    .buttonStyle(OutlinedButtonStyle())
                    .padding([.horizontal, .top], 30)
                }
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
        .navigationBarItems(trailing: Button(action: {
            viewModel.settingsButtonTapped()
        }) {
            Image(systemName: "gearshape")
                .resizable()
                .padding(4)
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                .foregroundColor(.white)
        })
    }
}

fileprivate struct Constants {
    static let rowSideInsets: CGFloat = 10
    static let rowTopInsets: CGFloat = 10
    static let rowBottomInsets: CGFloat = 10
    static let characterListIdentifier: String = "CharacterList"
    static let characterCellIdentifier: String = "CharacterCell"
}

// MARK: - Row Delegate
extension LoginView: LoginViewDelegate {
    func loginButtonTapped() {
        viewModel.login()
    }
}


// MARK: - Preview
struct LoginView_Previews: PreviewProvider {
    @State static var coordinator = StockItCoordinator()
    static var previews: some View {
        LoginViewBuilder.build(coordinator: coordinator)
    }
}
