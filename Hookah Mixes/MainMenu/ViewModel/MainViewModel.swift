//
//  MainViewModel.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 13.04.2023.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var mainCell = [CollectionCellInfo]()
    @Published var news: CollectionCellInfo
    let servise = CollectionCellServises()
    let newsArray = ["tobacco", "advice", "hookah"]
    
    init(news: CollectionCellInfo) {
        self.news = news
        fetchMainCell()
    }
    
    func fetchMainCell() {
        
        for i in 0 ..< newsArray.count {
            servise.fetchNews(news: newsArray[i]) { mainCell in
                self.mainCell.append(contentsOf: mainCell)
            }
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
