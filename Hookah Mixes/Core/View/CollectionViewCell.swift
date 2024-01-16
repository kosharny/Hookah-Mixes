//
//  CollectionViewCell.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 04.04.2023.
//

import SwiftUI
import Kingfisher


struct CollectionViewCell: View {
    let width = UIScreen.main.bounds.width - 40
    let height = UIScreen.main.bounds.height / 2 - 130
    var collectionCellInfo = CollectionCellInfo(imageName: "", textLabel: "")
    
    @State private var isLoading = false
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width - 40))
    ]
    
    var body: some View {
        
            LazyVGrid(columns: adaptiveColumns) {
                ZStack {
                    KFImage(URL(string: collectionCellInfo.imageName))
                        .onProgress { receivedSize, totalSize in
                                        if !self.isLoading {
                                            self.isLoading = true
                                        }
                                    }
                                    .placeholder {
                                        if isLoading {
                                            ProgressView()
                                        } else {
                                            Image(systemName: "photo")
                                        }
                                    }
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                    VStack {
                        
                        Spacer()
                        
                        VStack {
                            VStack {
                                Spacer()
                                
                                ZStack {
                                    Rectangle()
                                        .frame(width: width, height: 160)
                                        .foregroundColor(Color.gray)
                                        .opacity(0.8)
                                    Text(collectionCellInfo.textLabel)
                                        .padding()
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .foregroundColor(Color("TextFooterColor"))
                                }
                            }
                            
                        }
                        .frame(width: width)
                        .background(Color.clear)
                    }
                }
                .frame(width: width, height: height)
                .cornerRadius(16)
            }
            .padding(.vertical, 4)
            }
        }


struct CollectionViewCell_Previews: PreviewProvider {
    static var previews: some View {
        CollectionViewCell(collectionCellInfo: CollectionCellInfo(imageName: "imagePreview", textLabel: " Табак must have: получить максимум "))
    }
}
