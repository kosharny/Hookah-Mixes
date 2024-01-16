//
//  SignInView.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 03.04.2023.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct SignInView: View {
    private var width = UIScreen.main.bounds.width - 40
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        signInView
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

extension SignInView {
    var signInView: some View {
        NavigationStack {
            VStack {
                Text("У ТЕБЯ ЕСТЬ АККАУНТ?")
                    .padding(.top, 80)
                    .font(.largeTitle)
                    .foregroundColor(Color("TextFooterColor"))
                Divider()
                    .frame(width: width)
                    .overlay(Color("TextFooterColor"))
                
                TextField("Email", text: $email)
                    .keyboardType(.URL)
                    .autocapitalization(.none)
                    .padding(.top, 44)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .textFieldStyle(.roundedBorder)
                
                SecureField("Пароль", text: $password)
                    .autocapitalization(.none)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    viewModel.login(withEmail: email, password: password)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: width, height: UIScreen.main.bounds.height/16)
                            .foregroundColor(Color("FooterColor"))
                        
                        Text("ВОЙТИ")
                            .font(.largeTitle)
                            .foregroundColor(Color("TextFooterColor"))
                    }
                    .padding(.top, 32)
                }
                
                    GoogleSignInButton {
                        viewModel.signInWithGoogle()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal, 20)
                
                
                
                NavigationLink {
                    RegistrationView()
                } label: {
                    Text("Создать аккаунт?")
                        .padding(.top, 2)
                        .foregroundColor(Color("TextFooterColor"))
                }
                
                Spacer()
                
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 130)
            .background(Color("Background"))
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $viewModel.didAuthUser) {
            AccountView()
        }
    }
}


