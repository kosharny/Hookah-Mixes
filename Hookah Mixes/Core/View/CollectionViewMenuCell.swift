//
//  CollectionViewMenuCell.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 13.04.2023.
//

import SwiftUI

struct CollectionViewMenuCell: View {
    let width = UIScreen.main.bounds.width - 40
    let height = UIScreen.main.bounds.height / 2 - 130
    var collectionCellInfo = CollectionCellInfo(imageName: "", textLabel: "")
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width - 40))
    ]
    
    var body: some View {
        
            LazyVGrid(columns: adaptiveColumns) {
                ZStack {
                    Image(collectionCellInfo.imageName)
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
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity, alignment: .leading)
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

struct CollectionViewMenuCell_Previews: PreviewProvider {
    static var previews: some View {
        CollectionViewCell(collectionCellInfo: CollectionCellInfo(imageName: "imagePreview", textLabel: " Табак must have: получить максимум "))
    }
}
