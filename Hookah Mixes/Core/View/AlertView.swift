//
//  AlertView.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 17.04.2023.
//

import SwiftUI

struct AlertView: View {
    @Binding var showPopUp: Bool
    let width = UIScreen.main.bounds.width / 2.5
    
    var body: some View {
        
        
        if showPopUp {
            withAnimation {
                VStack {
                    Text("Сохраненно")
                        .scaleEffect(showPopUp ? 1 : 0.5)
                        .opacity(showPopUp ? 1 : 0)
                        .font(.title3)
                        .foregroundColor(Color("TextFooterColor"))
                }
                .scaleEffect(showPopUp ? 1 : 0.5)
                .opacity(showPopUp ? 1 : 0)
                .frame(width: width, height: 40)
                .background(Color("Background"))
                .cornerRadius(16)
                .padding(.top, 0)
                .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                self.showPopUp = false
                            }
                        }
            }
        }
    }
}
//
//struct AlertView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlertView()
//    }
//}
