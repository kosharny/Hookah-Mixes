//
//  CustomTabBar.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 06.04.2023.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case main = "Главная"
    case tobacco = "Табак"
    case hookah = "Кальян"
    case advaice = "Советы"
    case account = "Аккаунт"
}

struct CustomTabBar: View {
    @Binding var selectedIndex: Tab
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    HStack {
                        VStack {
                            Image("\(tab)")
                                .frame(width: 24, height: 24)
                                .scaleEffect(selectedIndex == tab ? 1.2 : 1.0)
                                .onTapGesture {
                                    withAnimation(.easeIn(duration: 0.1)) {
                                        selectedIndex = tab
                                    }
                                }
                            Text(tab.rawValue)
                                .font(.callout)
                                .foregroundColor(Color("TextFooterColor"))
                                .scaleEffect(selectedIndex == tab ? 1.0 : 0.8)
                        }
//                        if tab != .account {
//                            Divider()
//                                .frame(width: 0.5)
//                                .overlay(Color("TextFooterColor"))
//                        }
                    }
//                    .frame(height: 50)
                    Spacer()
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 90)
            .background(Color("FooterColor"))
            .cornerRadius(16)
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedIndex: .constant(.hookah))
    }
}
