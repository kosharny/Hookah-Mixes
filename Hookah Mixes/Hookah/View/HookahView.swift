//
//  HookahView.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 03.04.2023.
//

import SwiftUI

struct HookahView: View {
    
    @ObservedObject var viewModel: HookahViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showAlert = false
    @State private var collectionsInfo: CollectionCellInfo?
    
    init(news: CollectionCellInfo) {
        self.viewModel = HookahViewModel(news: news)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        HStack {
                            Spacer()
                            Text("КАЛЬЯН")
                                .foregroundColor(Color("TextFooterColor"))
                                .font(.largeTitle.bold())
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal, 24)
                        
                        Divider()
                            .frame(width: 380)
                            .overlay(Color("TextFooterColor"))
                        
                        
                        ForEach(viewModel.hookah) { hookah in
                            Button {
                                self.collectionsInfo = CollectionCellInfo(imageName: hookah.imageName, textLabel: hookah.textLabel, text: hookah.text ?? "", tobaccoName: hookah.tobaccoName ?? "")
                            } label: {
                                ZStack {
                                    CollectionViewCell(collectionCellInfo: CollectionCellInfo(imageName: hookah.imageName, textLabel: hookah.textLabel))
                                    if authViewModel.currenUser != nil {
                                        HStack {
                                            
                                            Spacer()
                                            
                                            VStack {
                                                
                                                Button {
                                                    viewModel.saveNews(ad: hookah)
                                                    showAlert = true
                                                } label: {
                                                    ZStack {
                                                        Circle()
                                                            .frame(width: 50, height: 50)
                                                            .foregroundColor(.gray)
                                                        Image(systemName: "bookmark")
                                                            .font(.title)
                                                            .foregroundColor(Color("TextFooterColor"))
                                                    }
                                                }
                                                Spacer()
                                                
                                            }
                                            .padding(.horizontal)
                                            
                                        }
                                        .padding()
                                    }
                                    Spacer()
                                }
                            }
                            .sheet(item: $collectionsInfo) { collectionsInfo in
                                NewsView(collectionCellInfo: collectionsInfo)
                            }
                        }
                    }
                }
                .scrollIndicators(.visible)
                .frame(width: 430)
                .background(Color("Background"))
                VStack {
                    Spacer()
                    
                    AlertView(showPopUp: $showAlert)
                }
            }
        }
    }
}

//struct HookahView_Previews: PreviewProvider {
//    static var previews: some View {
//        HookahView()
//    }
//}
