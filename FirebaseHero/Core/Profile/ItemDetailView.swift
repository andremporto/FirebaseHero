//
//  ItemDetailView.swift
//  FirebaseHero
//
//  Created by André Porto on 23/05/24.
//

import SwiftUI

struct ItemDetailView: View {
    @ObservedObject var viewModel = ItemViewModel()
    var item: Item
    @State private var name: String
    @State private var description: String
    
    init(item: Item) {
        self.item = item
        _name = State(initialValue: item.name)
        _description = State(initialValue: item.description)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Item Details")) {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
            }
            
            Button("Atualizar Chave") {
                let updatedItem = Item(id: item.id, name: name, description: description, timestamp: item.timestamp)
                viewModel.updateItem(item: updatedItem)
            }
        }
        .navigationTitle("Detalhes da Chave")
    }
}


//#Preview {
//    ItemDetailView()
//}

#Preview {
    ItemDetailView(item: Item(name: "Exemplo", description: "Descricao de exemplo", timestamp: Date()))
}
