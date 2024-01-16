//
//  FilterViewModel.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 27.04.2023.
//

import Foundation

class FilterViewModel: ObservableObject {
    @Published var tobaccoMixes = [CollectionCellInfo]()
    let servise = CollectionCellServises()
    
    init() {
        fetchFilterTobaccoNameNews(filterName: "")
//        fetchFilterStrenghtNews(filterName: "")
    }
    
    func fetchFilterTobaccoNameNews(filterName: String) {
        servise.fetchFilterTobaccoNameNews(filterName: filterName) { tobaccoMixes in
                self.tobaccoMixes = tobaccoMixes
        }
    }
    
    func fetchFilterStrenghtNews(filterName: String) {
        servise.fetchFilterStrenghtNews(filterName: filterName) { tobaccoMixes in
                self.tobaccoMixes = tobaccoMixes
        }
    }
}
