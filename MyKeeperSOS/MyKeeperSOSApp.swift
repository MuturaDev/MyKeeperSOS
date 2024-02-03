//
//  MyKeeperSOSApp.swift
//  MyKeeperSOS
//
//  Created by JamesMutura on 08/10/2023.
//

import SwiftUI

@main
struct MyKeeperSOSApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
