//
//  UberCloneApp.swift
//  UberClone
//
//  Created by Tom Miller on 03/12/2022.
//

import SwiftUI
import Firebase

@main
struct UberCloneApp: App {
    @StateObject var locationViewModel = LocationSearchViewModel()
    @StateObject var launchScreenManager = LaunchScreenManager()
    @StateObject var authViewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ZStack{
                HomeView()
                    .environmentObject(locationViewModel)
                if launchScreenManager.state != .completed{
                    LaunchScreen()
                        .environmentObject(authViewModel)
                }
            }
            .environmentObject(launchScreenManager)
        }
    }
}
