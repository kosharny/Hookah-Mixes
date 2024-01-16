//
//  LaunchScreen.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 04.04.2023.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color("FooterColor")
                VStack {
                    Image("HookahMixesLogo")
                    Text("Hookah")
                        .padding(.top)
                        .font(Font.custom("mirza", size: 80))
                        .foregroundColor(Color("TextFooterColor"))
                    Text("Mixes")
                        .font(Font.custom("mirza", size: 80))
                        .foregroundColor(Color("TextFooterColor"))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .ignoresSafeArea()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
