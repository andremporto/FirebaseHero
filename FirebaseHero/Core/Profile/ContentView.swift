//
//  ProfileView.swift
//  FirebaseHero
//
//  Created by André Porto on 23/05/24.
//

import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
}

struct ProfileView: View {
    @StateObject private var viewModel = ItemViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items) { item in
                    NavigationLink(destination: ItemDetailView(item: item)) {
                        Text(item.name)
                    }
                }
                .onDelete(perform: viewModel.deleteItem)
            }
            .navigationBarItems(trailing: NavigationLink("Adicionar", destination: AddItemView(viewModel: viewModel)))
        }
        .onAppear {
            viewModel.fetchItems()
        }
        .navigationTitle("Minhas Chaves")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink {
                    SettingsView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }
                
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView(showSignInView: .constant(false))
    }
}
