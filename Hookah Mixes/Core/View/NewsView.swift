//
//  NewsView.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 05.04.2023.
//

import SwiftUI
import Kingfisher

struct NewsView: View {
    let width = UIScreen.main.bounds.width - 20
    var collectionCellInfo = CollectionCellInfo(imageName: "", textLabel: "", text: "")
    
    var body: some View {
        
        ScrollView {
            ZStack {
                KFImage(URL(string: collectionCellInfo.imageName))
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: width)
                VStack {
                    
                    Spacer()
                    
                    VStack {
                        Text(collectionCellInfo.textLabel)
                            .font(.title)
                            .foregroundColor(Color("TextFooterColor"))
                    }
                    .padding()
                    .frame(width: width)
                    .background(Color.gray)
                }
            }
            .frame(width: width)
            .cornerRadius(16)
            VStack {
                Text(collectionCellInfo.text ?? "")
                .padding()
                .foregroundColor(Color("TextFooterColor"))
                .background(Color.gray)
            }
            .background(Color.gray)
            .frame(width: width)
            .cornerRadius(16)
            .padding(.top, 0)
        }
        .padding(.top, 24)
        .frame(width: UIScreen.main.bounds.width)
        .background(Color("Background"))
    }
    
}


//struct NewsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewsView()
//    }
//}
