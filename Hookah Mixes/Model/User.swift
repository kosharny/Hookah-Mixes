//
//  User.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 18.04.2023.
//

import FirebaseFirestoreSwift
import Firebase

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let name: String
    let email: String
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id }
}
