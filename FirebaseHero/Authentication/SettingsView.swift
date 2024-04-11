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
    @Published var authUser: AuthDataResultModel? = nil
    
    func loadAuthProviders() {
        if let providers = try? AuthenticationManager.shared.getProviders() {
            authProviders = providers
        }
    }
    
    func loadAuthUser() {
        self.authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
    }
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func deleteAccount() async throws {
        try await AuthenticationManager.shared.delete()
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
    
    func linkGoogleAcount() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        self.authUser = try await AuthenticationManager.shared.linkGoogle(tokens: tokens)
    }
    
//    func linkAppleAcount() async throws {
//        let helper = SignInAppleHelper()
//        let tokens = try await helper.signInWithAppleFlow()
//        self.authUser = try await AuthenticationManager.shared.linkApple(tokens: tokens)
//    }
    
    func linkEmailAcount() async throws {
        let email = "hello123@gmail.com"
        let password = "hello123"
        self.authUser = try await AuthenticationManager.shared.linkEmail(email: email, password: password)
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
            
            Button(role: .destructive) {
                Task {
                    do {
                        try await viewModel.deleteAccount()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Excluir conta")
            }

            
            if viewModel.authProviders.contains(.email) {
                emailSection
            }
            
            if viewModel.authUser?.isAnonymous == true {
                anonymousSection
            }
        }
        .onAppear {
            viewModel.loadAuthProviders()
            viewModel.loadAuthUser()
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
    
    private var anonymousSection: some View {
        Section {
            Button("Associar à conta Google") {
                Task {
                    do {
                        try await viewModel.linkGoogleAcount()
                        print("GOOGLE LINKADO!")
                    } catch {
                        print(error)
                    }
                }
            }
            
//            Button("Associar à conta Apple") {
//                Task {
//                    do {
//                        try await viewModel.linkAppleAcount()
//                        print("APPLE LINKADA!")
//                    } catch {
//                        print(error)
//                    }
//                }
//            }
            
            Button("Associar à conta de Email") {
                Task {
                    do {
                        try await viewModel.linkEmailAcount()
                        print("EMAIL LINKADO!")
                    } catch {
                        print(error)
                    }
                }
            }
        } header: {
            Text("Criar Conta")
        }
    }
}
