//
//  SettingsView.swift
//  FirebaseHero
//
//  Created by André Porto on 04/04/24.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderOption] = []
    
    func loadAuthProviders() {
        if let providers = try? AuthenticationManager.shared.getProviders() {
            authProviders = providers
        }
    }
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func resetPassord() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updateEmail() async throws {
        let email = "hello123@gmail.com"
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
    func updatePassword() async throws {
        let password = "hello123"
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
    
}

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            Button("Sair") {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }
            
            if viewModel.authProviders.contains(.email) {
                emailSection
            }
            emailSection
        }
        .onAppear {
            viewModel.loadAuthProviders()
        }
        .navigationTitle("Configurações")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
    }
}

extension SettingsView {
    
    private var emailSection: some View {
        Section {
            Button("Resetar Senha") {
                Task {
                    do {
                        try await viewModel.resetPassord()
                        print("SENHA RESETADAhello2@testing.com")
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("Atualizar Senha") {
                Task {
                    do {
                        try await viewModel.updatePassword()
                        print("SENHA ATUALIZADA!")
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("Atualizar Email") {
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("EMAIL ATUALIZADO!")
                    } catch {
                        print(error)
                    }
                }
            }
        } header: {
            Text("Configurações da Conta")
        }
    }
}
