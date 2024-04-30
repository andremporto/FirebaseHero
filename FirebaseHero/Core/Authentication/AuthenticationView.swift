//
//  AuthenticationView.swift
//  FirebaseHero
//
//  Created by André Porto on 02/04/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct AuthenticationView: View {
    
    @StateObject private var viewmodel = AuthenticationViewModel()
    @Binding var showSignView: Bool
    
    var body: some View {
        VStack {
            
            Button (action: {
                Task {
                    do {
                        try await viewmodel.signInAnonymous()
                        showSignView = false
                    } catch {
                        print(error)
                    }
                }
            }, label: {
                Text("Entrar Anônimo")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
            })
            
            NavigationLink {
                SignInEmailView(showSignInView: $showSignView)
            } label: {
                Text("Entrar com Email")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
            }
            
            GoogleSignInButton(scheme: .dark, style: .wide, state: .normal) {
                Task {
                    do {
                        try await viewmodel.signInGoogle()
                        showSignView = false
                    } catch {
                        print(error)
                    }
                }
            }
            
            Spacer()
            
        }
        .padding()
        .navigationTitle("Login")
    }
}

#Preview {
    NavigationStack {
        AuthenticationView(showSignView: .constant(false))
    }
}
