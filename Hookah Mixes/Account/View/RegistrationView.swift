//
//  RegistrationView.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 08.04.2023.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct RegistrationView: View {
    private var width = UIScreen.main.bounds.width - 40
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("СОЗДАТЬ АККАУНТ?")
                    .padding(.top, 80)
                    .font(.largeTitle)
                    .foregroundColor(Color("TextFooterColor"))
                Divider()
                    .frame(width: width)
                    .overlay(Color("TextFooterColor"))
                
                
                
                TextField("Имя", text: $name)
                    .autocapitalization(.none)
                    .padding(.top, 44)
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .keyboardType(.URL)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .textFieldStyle(.roundedBorder)
                
                SecureField("Пороль", text: $password)
                    .autocapitalization(.none)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .textFieldStyle(.roundedBorder)
                
                SecureField("Повторите пароль", text: $confirmPassword)
                    .autocapitalization(.none)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    if password == confirmPassword {
                        viewModel.register(withEmail: email, password: password, name: name)
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: width, height: UIScreen.main.bounds.height/16)
                            .foregroundColor(Color("FooterColor"))
                        
                        Text("ЗАРЕГИСТРИРОВАТЬСЯ")
                            .font(.title)
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
                    SignInView()
                } label: {
                    Text("У тебя есть аккаунт?")
                        .padding(.top, 2)
                        .foregroundColor(Color("TextFooterColor"))
                    
                }
                
                Spacer()
                
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 130)
            .background(Color("Background"))
        }
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $viewModel.didAuthUser) {
            AccountView()
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
