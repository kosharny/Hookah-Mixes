//
//  AuthViewModel.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 18.04.2023.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var didAuthUser = false
    @Published var currenUser: User?
    private var tempUserSession: FirebaseAuth.User?
    
    private let service = UserService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
        }
    }
    
    func register(withEmail email: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.tempUserSession = user
            
            let data = ["email": email,
                        "name": name,
                        "uid": user.uid]
            
            Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                self.didAuthUser = true
            }
        }
    }
    
    func signOut() {
        // sets user session to nil so we show login view
        userSession = nil
        
        // signs user out on server
        try? Auth.auth().signOut()
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        
        service.fetch(withUid: uid) { user in
            self.currenUser = user
        }
    }
    
    func signInWithGoogle(){
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("No client ID found in Firebase onfiguretion")
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            print ("There is no root view controller")
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            guard error == nil else { return }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print("DEBUG: Failed to register with error \(error.localizedDescription)")
                    return
                }
                
                guard let user = result?.user else { return }
                self.tempUserSession = user
                let name = String(result!.user.email?.dropLast(10) ?? "")
                let data = ["email": result!.user.email,
                            "name": name,
                            "uid": user.uid]
                
                Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                    self.didAuthUser = true
                }
                self.userSession = user
            }
        }
    }
}

