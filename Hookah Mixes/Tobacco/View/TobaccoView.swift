//
//  TobaccoView.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 03.04.2023.
//

import SwiftUI

struct TobaccoView: View {
    
    
    @ObservedObject var viewModel: TobaccoMixesViewModel
    @State private var collectionsInfo: CollectionCellInfo?
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var isFiltered = false
    @State private var showFilter = false
    @State private var isNewsView = false
    @State private var showAlert = false
    @State private var isCollectionViewMixes = false
    @State private var isCollectionViewRating = false
    var data: [Int] = Array(1...20)
    
    init(news: CollectionCellInfo) {
        self.viewModel = TobaccoMixesViewModel(news: news)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                Button {
                    self.isCollectionViewMixes.toggle()
                } label: {
                    CollectionViewMenuCell(collectionCellInfo: CollectionCellInfo(imageName: "mixes", textLabel: "МИКСЫ"))
                }
                .sheet(isPresented: $isCollectionViewMixes) {
                    withAnimation(.easeIn(duration: 0.3)) {
                        ZStack {
                            ScrollView {
                                VStack {
                                    HStack {
                                        Button {
                                            withAnimation(.easeIn(duration: 0.3)) {
                                                self.showFilter.toggle()
                                            }
                                        } label: {
                                            Image(systemName: showFilter ? "xmark" : "slider.horizontal.3")
                                                .font(.largeTitle)
                                                .foregroundColor(Color(("TextFooterColor")))
                                        }
                                        
                                        Spacer()
                                        Text("Миксы")
                                            .font(.largeTitle.bold())
                                            .foregroundColor(Color(("TextFooterColor")))
                                    }
                                    .padding(.top, 24)
                                    .padding(.horizontal, 20)
                                    
                                    
                                    Divider()
                                        .frame(width: 380)
                                        .overlay(Color("TextFooterColor"))
                                    
                                    if showFilter {
                                        FilterView(isFiltered: $isFiltered, showFilter: $showFilter)
                                    } else {
                                        
                                        ForEach(viewModel.tobaccoMixes) { tobaccoMixes in
                                            
                                            Button {
                                                self.collectionsInfo = CollectionCellInfo(imageName: tobaccoMixes.imageName, textLabel: tobaccoMixes.textLabel, text: tobaccoMixes.text ?? "", tobaccoName: tobaccoMixes.tobaccoName ?? "")
                                            } label: {
                                                ZStack {
                                                    CollectionViewCell(collectionCellInfo: CollectionCellInfo(imageName: tobaccoMixes.imageName, textLabel: tobaccoMixes.textLabel))
                                                    if authViewModel.currenUser != nil {
                                                        HStack {
                                                            
                                                            Spacer()
                                                            
                                                            VStack {
                                                                
                                                                Button {
                                                                    viewModel.saveNews(ad: tobaccoMixes)
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
                            }
                            .scrollIndicators(.visible)
                            .background(Color("Background"))
                            .navigationBarBackButtonHidden()
                            
                            VStack {
                                Spacer()
                                
                                AlertView(showPopUp: $showAlert)
                            }
                        }
                    }
                }
                Button {
                    self.isCollectionViewRating.toggle()
                } label: {
                    CollectionViewMenuCell(collectionCellInfo: CollectionCellInfo(imageName: "rating", textLabel: "РЕЙТИНГ ТАБАКОВ"))
                }
                .sheet(isPresented: $isCollectionViewRating){
                    withAnimation(.easeIn(duration: 0.3)) {
                                RaitingView()
                    }
                }
            }
        }
        .frame(width: 430)
        .background(Color("Background"))
    }
}


//struct TobaccoView_Previews: PreviewProvider {
//    static var previews: some View {
//        TobaccoView()
//    }
//}


