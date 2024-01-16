//
//  MainView.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 03.04.2023.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var refresh = Refresh(started: false, released: false)
    @State private var showAlert = false
    @State private var collectionsInfo: CollectionCellInfo?
    let impactGenerator = UIImpactFeedbackGenerator(style: .rigid)
    var data: [Int] = Array(1...20)
    
    init(news: CollectionCellInfo) {
        self.viewModel = MainViewModel(news: news)
    }
    
    var body: some View {
        ZStack {
            
            
            
            ScrollView {
                
                if refresh.started && refresh.released {
                    ProgressView()
                        .offset(y: 15)
                }

                GeometryReader { reader -> AnyView in
                    DispatchQueue.main.async {
                        if refresh.startOffset == 0 {
                            refresh.startOffset = reader.frame(in: .global).minY
                        }
                        
                        refresh.offset = reader.frame(in: .global).minY
                        
                        if refresh.offset - refresh.startOffset > 120 && !refresh.started {
                            refresh.started = true
                        }
                        
                        if refresh.startOffset == refresh.offset && refresh.started && !refresh.released {
                            withAnimation(Animation.linear){refresh.released = true}
                            updateDate()
                        }
                    }
                    
                    return AnyView(Color.black.frame(width: 0, height: 0))
                }
                ForEach(viewModel.mainCell) { mainCell in
                    Button {
                        self.collectionsInfo = CollectionCellInfo(imageName: mainCell.imageName, textLabel: mainCell.textLabel, text: mainCell.text ?? "", tobaccoName: mainCell.tobaccoName ?? "")
                    } label: {
                        ZStack {
                            
                            CollectionViewCell(collectionCellInfo: CollectionCellInfo(imageName: mainCell.imageName, textLabel: mainCell.textLabel))
                            HStack {
                                if authViewModel.currenUser != nil {
                                    Spacer()
                                    
                                    VStack {
                                        
                                        Button {
                                            viewModel.saveNews(ad: mainCell)
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
                            }
                            .padding()
                            
                            Spacer()
                        }
                    }
                    .sheet(item: $collectionsInfo) { collectionsInfo in
                        NewsView(collectionCellInfo: collectionsInfo)
                    }
                }
                
            }
            .scrollIndicators(.visible)
            .offset(y: refresh.released ? 15 : -10)
            .frame(width: 430)
            .background(Color("Background"))
          
            VStack {
                Spacer()
                
                AlertView(showPopUp: $showAlert)
            }
        }
    }
    
    func updateDate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(Animation.linear) {
                impactGenerator.impactOccurred()
                refresh.released = false
                refresh.started = false
            }
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}


struct Refresh {
    var startOffset: CGFloat = 0
    var offset: CGFloat = 0
    var started: Bool
    var released: Bool
}
