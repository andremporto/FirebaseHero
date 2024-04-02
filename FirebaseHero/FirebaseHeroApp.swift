//
//  FirebaseHeroApp.swift
//  FirebaseHero
//
//  Created by André Porto on 02/04/24.
//

import SwiftUI
import Firebase

@main
struct FirebaseHeroApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
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
