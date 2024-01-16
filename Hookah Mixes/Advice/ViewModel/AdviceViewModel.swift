//
//  AdviceViewModel.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 11.04.2023.
//

import Foundation

class AdviceViewModel: ObservableObject {
    @Published var didSaveNews = false
    @Published var news: CollectionCellInfo
    @Published var advice = [CollectionCellInfo]()
    let servise = CollectionCellServises()
    
    init(news: CollectionCellInfo) {
        self.news = news
        self.fetchAdvice()
    }
    
    func fetchAdvice() {
        servise.fetchNews(news: "advice") { advice in
            self.advice = advice
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
