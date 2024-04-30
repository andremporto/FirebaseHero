//
//  SettingsView.swift
//  FirebaseHero
//
//  Created by André Porto on 04/04/24.
//

import SwiftUI

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
