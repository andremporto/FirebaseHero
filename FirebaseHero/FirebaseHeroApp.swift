//
//  FirebaseHeroApp.swift
//  FirebaseHero
//
//  Created by André Porto on 23/05/24.
//

import SwiftUI
import Firebase

@main
struct FirebaseHeroApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Configured Firebase")
        
        return true
    }
}
