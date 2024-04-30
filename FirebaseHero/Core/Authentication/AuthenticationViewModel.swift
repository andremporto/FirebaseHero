//
//  AuthenticationViewModel.swift
//  FirebaseHero
//
//  Created by André Porto on 29/04/24.
//

import Foundation

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        try await UserManager.shared.createUser(auth: authDataResult)
    }
    
//    func signInApple() async throws {
//        let helper = SignInAppleHelper()
//        let tokens = try await helper.startSignInWithAppleFlow()
//        let authDataResult = try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
//        try await UserManager.shared.createUser(auth: authDataResult)
//    }
    
    func signInAnonymous() async throws {
        let authDataResult = try await AuthenticationManager.shared.signInAnonymous()
        try await UserManager.shared.createUser(auth: authDataResult)
    }
}
