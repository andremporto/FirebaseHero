//
//  Item.swift
//  FirebaseHero
//
//  Created by André Porto on 23/05/24.
//

import Foundation
import FirebaseFirestore

struct Item: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var name: String
    var description: String
    var timestamp: Date
}
