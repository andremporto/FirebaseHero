//
//  SettingsViewModel.swift
//  FirebaseHero
//
//  Created by André Porto on 23/05/24.
//

import Foundation

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
