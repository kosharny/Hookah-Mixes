//
//  Hookah_MixesApp.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 26.03.2023.
//

import SwiftUI
import Firebase

@main
struct Hookah_MixesApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchScreen()
                .environmentObject(viewModel)
        }
    }
}
