//
//  ItemViewModel.swift
//  FirebaseHero
//
//  Created by André Porto on 23/05/24.
//

import SwiftUI
import FirebaseFirestore

class ItemViewModel: ObservableObject {
    @Published var items = [Item]()
    private var db = Firestore.firestore()
    
    func fetchItems() {
        db.collection("items").order(by: "timestamp").addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.items = querySnapshot.documents.compactMap { document -> Item? in
                    try? document.data(as: Item.self)
                }
            }
        }
    }
    
    func addItem(item: Item) {
        do {
            _ = try db.collection("items").addDocument(from: item)
        } catch {
            print(error)
        }
    }
    
    func updateItem(item: Item) {
        if let documentId = item.id {
            do {
                try db.collection("items").document(documentId).setData(from: item)
            } catch {
                print(error)
            }
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        offsets.forEach { index in
            let item = items[index]
            if let documentId = item.id {
                db.collection("items").document(documentId).delete { error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
