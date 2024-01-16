//
//  CollectionCellInfo.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 10.04.2023.
//

import FirebaseFirestoreSwift
import Firebase

struct CollectionCellInfo: Identifiable, Decodable, Hashable {
    
    @DocumentID var id: String?
    var imageName: String
    var textLabel: String
    var text: String?
    var tobaccoName: String?
    var sourSweet: String?
    var country: String?
    var strength: String?
    var heatResistance: String?
    var date: Timestamp?
    
    var isSave: Bool? = false
}
