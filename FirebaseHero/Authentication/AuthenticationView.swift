//
//  AuthenticationView.swift
//  FirebaseHero
//
//  Created by André Porto on 02/04/24.
//

import SwiftUI

struct AuthenticationView: View {
    
    @Binding var showSignView: Bool
    
    var body: some View {
        VStack {
            
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
