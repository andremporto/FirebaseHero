//
//  RootView.swift
//  FirebaseHero
//
//  Created by André Porto on 04/04/24.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSIgnInView: Bool = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                SettingsView(showSignInView: $showSIgnInView)
            }
        }
        .onAppear {
            let authuser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSIgnInView = authuser == nil ? true : false
        }
        .fullScreenCover(isPresented: $showSIgnInView) {
            NavigationStack {
                AuthenticationView(showSignView: $showSIgnInView)
            }
        }
    }
}

#Preview {
    RootView()
}
