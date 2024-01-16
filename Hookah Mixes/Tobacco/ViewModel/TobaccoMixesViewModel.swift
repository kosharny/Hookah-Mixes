//
//  TobaccoMixesViewModel.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 13.04.2023.
//

import Foundation

class TobaccoMixesViewModel: ObservableObject {
    @Published var tobaccoMixes = [CollectionCellInfo]()
    @Published var news: CollectionCellInfo
    let servise = CollectionCellServises()
    
    init(news: CollectionCellInfo) {
        self.news = news
        fetchTobaccoMixes()
    }
    
    func fetchTobaccoMixes() {
        servise.fetchNews(news: "tobacco") { tobaccoMixes in
            self.tobaccoMixes = tobaccoMixes
        }
    }
    
    func saveNews(ad: CollectionCellInfo) {
        servise.saveNews(textLabel: ad.textLabel, imageName: ad.imageName, text: ad.text ?? "") { success in
            if success {
                self.news.isSave = true
            }
        }
    }
}
