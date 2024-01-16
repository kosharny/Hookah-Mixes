//
//  AccountView.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 09.04.2023.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    @ObservedObject var accountViewModel = AccountViewModel()
    
    @State private var showFilter = false
    @State private var isNewsView = false
    @State private var isCollectionViewSave = false
    
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    if let user = viewModel.currenUser {
                        Text("Привет, \(user.name)!")
                            .foregroundColor(Color("TextFooterColor"))
                            .font(.largeTitle.bold())
                    }
                }
                .padding(.top, 56)
                .padding(.bottom, 4)
                .padding(.horizontal, 24)
                
                Divider()
                    .frame(width: 380)
                    .overlay(Color("TextFooterColor"))
                
                Button {
                    self.isCollectionViewSave.toggle()
                } label: {
                    CollectionViewMenuCell(collectionCellInfo: CollectionCellInfo(imageName: "mixes", textLabel: "СОХРАНЕННЫЕ"))
                }
                .padding()
                .sheet(isPresented: $isCollectionViewSave) {
                    withAnimation(.easeIn(duration: 0.3)) {
                        ScrollView {
                            VStack {
                                HStack {
                                    Spacer()
                                    Text("СОХРАНЕННЫЕ")
                                        .font(.title.bold())
                                        .foregroundColor(Color(("TextFooterColor")))
                                }
                                .padding(.top, 24)
                                .padding(.horizontal, 20)
                                
                                
                                Divider()
                                    .frame(width: 380)
                                    .overlay(Color("TextFooterColor"))
                                
                               
                                
                                ForEach(accountViewModel.saveNews) { saveNews in
                                    Button {
                                        self.isNewsView.toggle()
                                    } label: {
                                            CollectionViewCell(collectionCellInfo: CollectionCellInfo(imageName: saveNews.imageName, textLabel: saveNews.textLabel))
                                        
                                    }
                                    .sheet(isPresented: $isNewsView) {
                                        NewsView(collectionCellInfo: CollectionCellInfo(imageName: saveNews.imageName, textLabel: saveNews.textLabel, text: saveNews.text ?? ""))
                                    }
                                }
                            }
                        }
                        .background(Color("Background"))
                        .navigationBarBackButtonHidden()
                    }
                }
                
                Spacer()
                
                Button {
                    viewModel.signOut()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 60)
                            .foregroundColor(Color("FooterColor"))
                        
                        Text("ВЫЙТИ")
                            .font(.title)
                            .foregroundColor(Color(("TextFooterColor")))
                    }
                    .padding(.vertical, 56)
                }
                .navigationBarBackButtonHidden()
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 130)
            .background(Color("Background"))
        }
    }
}

//struct AccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountView()
//    }
//}
