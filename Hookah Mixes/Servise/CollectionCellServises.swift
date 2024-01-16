//
//  CollectionCellServises.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 11.04.2023.
//

import Firebase
import FirebaseStorage

struct CollectionCellServises {
    
    func fetchNews(news: String, comletion: @escaping([CollectionCellInfo]) -> Void) {
        Firestore.firestore().collection(news)
            .order(by: "date", descending: true)
            .getDocuments { snapshot, _ in
                guard let document = snapshot?.documents else { return }
                let newNews = document.compactMap({ try? $0.data(as: CollectionCellInfo.self) })
                comletion(newNews)
            }
    }
    
    func fetchSaveNews(comletion: @escaping([CollectionCellInfo]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var news = [CollectionCellInfo]()
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                documents.forEach { doc in
                    let newsID = doc.documentID
                    Firestore.firestore().collection("users")
                        .document(uid)
                        .collection("user-likes")
                        .document(newsID)
                        .getDocument { snapshot, _ in
                            guard let newNews = try? snapshot?.data(as: CollectionCellInfo.self) else { return }
                            news.append(newNews)
                            comletion(news)
                        }
                }
            }
    }
    
    func fetchFilterTobaccoNameNews(filterName: String, comletion: @escaping([CollectionCellInfo]) -> Void) {
        
        var news = [CollectionCellInfo]()
        
        
        Firestore.firestore().collection("tobacco")
            .getDocuments { snapshot, _ in
                guard let document = snapshot?.documents else { return }
                let newNews = document.compactMap({ try? $0.data(as: CollectionCellInfo.self) })
                news = newNews.filter({ n in
                    return n.tobaccoName == filterName
                })
                comletion(news)
                
            }
        
    }
    
    func fetchFilterStrenghtNews(filterName: String, comletion: @escaping([CollectionCellInfo]) -> Void) {
        
        var news = [CollectionCellInfo]()
        
        
        Firestore.firestore().collection("tobacco")
            .getDocuments { snapshot, _ in
                guard let document = snapshot?.documents else { return }
                let newNews = document.compactMap({ try? $0.data(as: CollectionCellInfo.self) })
                news = newNews.filter({ n in
                    return n.strength == filterName
                })
                comletion(news)
                
            }
        
    }
    
    
    func saveNews(textLabel: String, imageName: String, text: String, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["uid": uid,
                    "textLabel": textLabel,
                    "imageName": imageName,
                    "text": text] as [String: Any]
        
        Firestore.firestore().collection("users").document(uid).collection("user-likes").document()
            .setData(data) { error in
                if let error = error {
                    print("DEBUG: Failed to upload tweet with: error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }
}
