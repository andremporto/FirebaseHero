//
//  AddItemView.swift
//  FirebaseHero
//
//  Created by André Porto on 23/05/24.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ItemViewModel
    @State private var name = ""
    @State private var description = ""
    
    
    var body: some View {
        Form {
            Section(header: Text("Detalhes da Chave")) {
                TextField("Nome", text: $name)
                TextField("Chave", text: $description)
            }
            
            Button("Adicionar Chave") {
                let newItem = Item(name: name, description: description, timestamp: Date())
                viewModel.addItem(item: newItem)
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationTitle("Adicionar Chave")
    }
}

//#Preview {
//    AddItemView()
//}
#Preview {
    AddItemView(viewModel: ItemViewModel())
}
