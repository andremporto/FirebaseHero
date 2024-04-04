//
//  SignInEmailView.swift
//  FirebaseHero
//
//  Created by André Porto on 02/04/24.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}

struct SignInEmailView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        
        NavigationStack {
            VStack {
                TextField("Email...", text: $viewModel.email)
                    .padding()
                    .background(.gray.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                SecureField("Senha...", text: $viewModel.password)
                    .padding()
                    .background(.gray.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button {
                    Task {
                        do {
                            try await viewModel.signUp()
                            showSignInView = false
                            return
                        } catch {
                            print(error)
                        }
                        
                        do {
                            try await viewModel.signIn()
                            showSignInView = false
                            return
                        } catch {
                            print(error)
                        }
                        
                    }
                } label: {
                    Text("Login")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Entrar com Email")
        }
    }
}

#Preview {
    SignInEmailView(showSignInView: .constant(false))
}
