//
//  HookahViewModel.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 13.04.2023.
//

import Foundation

class HookahViewModel: ObservableObject {
    @Published var hookah = [CollectionCellInfo]()
    @Published var news: CollectionCellInfo
    let servise = CollectionCellServises()
    
    init(news: CollectionCellInfo) {
        self.news = news
        fetchHookah()
    }
    
    func fetchHookah() {
        servise.fetchNews(news: "hookah") { hookah in
            self.hookah = hookah
            print("DEBUG: \(hookah)")
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
