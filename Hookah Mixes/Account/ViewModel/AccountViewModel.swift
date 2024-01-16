//
//  AccountViewModel.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 21.04.2023.
//

import Foundation

class AccountViewModel: ObservableObject {
    
    @Published var saveNews = [CollectionCellInfo]()
    let servise = CollectionCellServises()
    
    init() {
        self.fetchAdvice()
    }
    
    func fetchAdvice() {
        servise.fetchSaveNews() { saveNews in
            self.saveNews = saveNews
        }
    }
    
    
}
