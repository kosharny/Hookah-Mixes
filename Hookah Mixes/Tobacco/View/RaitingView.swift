//
//  RaitingView.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 25.04.2023.
//

import SwiftUI

struct RaitingView: View {
    let tobaccoNames = [
        TobaccoRatingName(id: UUID(), name: "Fumari", rating: 5),
        TobaccoRatingName(id: UUID(), name: "Starbuzz", rating: 5),
        TobaccoRatingName(id: UUID(), name: "Milano", rating: 4),
        TobaccoRatingName(id: UUID(), name: "MustHave", rating: 3),
        TobaccoRatingName(id: UUID(), name: "DarkSide", rating: 4),
        TobaccoRatingName(id: UUID(), name: "Tangiers", rating: 5),
        TobaccoRatingName(id: UUID(), name: "Element", rating: 3)
    ]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Рейтинг табаков")
                    .font(.largeTitle.bold())
                    .foregroundColor(Color(("TextFooterColor")))
            }
            .padding(.top, 24)
            .padding(.horizontal, 20)
            
                List {
                    ForEach(tobaccoNames.sorted(by: { $0.rating > $1.rating }), id: \.id) {  tobaccoName in
                        VStack {
                            HStack {
                                Image(tobaccoName.name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50,height: 50)
                                    .cornerRadius(4)
                                Spacer()
                                Text(tobaccoName.name)
                                    .font(.title2.bold())
                                    .foregroundColor(Color(("TextFooterColor")))
                                Spacer ()
                                ForEach(0..<5) { i in
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(tobaccoName.rating > i ? .yellow : Color(("TextFooterColor")))
                                }
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 8)
                                Divider()
                                    .frame(width: 380)
                                    .overlay(Color("TextFooterColor"))
                           
                        }
                        .padding(.vertical, 0)
                    }
                    .listRowBackground(Color("Background"))
                }
                .scrollContentBackground(.hidden)
        }
        .background(Color("Background"))
    }
}

struct RaitingView_Previews: PreviewProvider {
    static var previews: some View {
        RaitingView()
    }
}

struct TobaccoRatingName: Identifiable{
    var id: UUID
    
    var name: String
    var rating: Int
}

