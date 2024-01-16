//
//  ContentView.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 26.03.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedIndex: Tab = .main
    @EnvironmentObject var viewModel: AuthViewModel
    var collectionCellInfo = CollectionCellInfo(imageName: "", textLabel: "", text: "")
    let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack {
            
            headerView
            customTab
        }
        .background(Color("Background"))
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}

extension ContentView {
    
    var headerView: some View {
        HStack {
            ZStack {
                Rectangle()
                    .cornerRadius(16)
                    .frame(height: 120)
                    .foregroundColor(Color("FooterColor"))
                VStack {
                    HStack {
                        Spacer()
                        Text("Hookah")
                            .padding(.top)
                            .font(Font.custom("mirza", size: 40))
                            .foregroundColor(Color("TextFooterColor"))
                        Image("HookahMixes")
                        Text("Mixes")
                            .padding(.top)
                            .font(Font.custom("mirza", size: 40))
                            .foregroundColor(Color("TextFooterColor"))
                        Spacer()
                    }
                    .padding(.top, 40)
                }
            }
        }
    }
    
    var customTab: some View {
        
        ZStack {
            VStack {
                    TabView(selection: $selectedIndex) {
                        ForEach(Tab.allCases, id: \.rawValue) { tab in
                            HStack {
                                switch selectedIndex {
                                case .main:
                                    MainView(news: collectionCellInfo)
                                case .tobacco:
                                    TobaccoView(news: collectionCellInfo)
                                case .hookah:
                                    HookahView(news: collectionCellInfo)
                                case .advaice:
                                    AdviceView(news: collectionCellInfo)
                                case .account:
                                    Group {
                                        // no user logged in
                                        if viewModel.userSession == nil {
                                            SignInView()
                                        } else {
                                            // have a logged in user
                                            AccountView()
                                        }
                                    }
                                }
                            }
                            .tag(tab)
                        }
                    }
                    .onChange(of: selectedIndex) { value in
                        impactGenerator.impactOccurred()
                    }
                
                CustomTabBar(selectedIndex: $selectedIndex)
            }
        }
    }
    
   
}
