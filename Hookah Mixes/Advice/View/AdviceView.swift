//
//  AdviceView.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 03.04.2023.
//

import SwiftUI

struct AdviceView: View {
    
    @ObservedObject var viewModel: AdviceViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var collectionsInfo: CollectionCellInfo?
    @State private var showAlert = false
    init(news: CollectionCellInfo) {
        self.viewModel = AdviceViewModel(news: news)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        HStack {
                            
                            Spacer()
                            Text("СОВЕТЫ")
                                .foregroundColor(Color("TextFooterColor"))
                                .font(.largeTitle.bold())
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal, 24)
                        
                        Divider()
                            .frame(width: 380)
                            .overlay(Color("TextFooterColor"))
                        
                        
                        ForEach(viewModel.advice) { advice in
                            Button {
                                self.collectionsInfo = CollectionCellInfo(imageName: advice.imageName, textLabel: advice.textLabel, text: advice.text ?? "", tobaccoName: advice.tobaccoName ?? "")
                            } label: {
                                ZStack {
                                    CollectionViewCell(collectionCellInfo: CollectionCellInfo(imageName: advice.imageName, textLabel: advice.textLabel))
                                    if authViewModel.currenUser != nil {
                                        HStack {
                                            
                                            Spacer()
                                            
                                            VStack {
                                                
                                                Button {
                                                    viewModel.saveNews(ad: advice)
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

//struct AdviceView_Previews: PreviewProvider {
//    static var previews: some View {
//        AdviceView()
//    }
//}
