//
//  Wi_Fi_ShareApp.swift
//  Wi-Fi Share
//
//  Created by Садырев Дмитрий on 08.09.2025.
//

import SwiftUI

@main
struct Wi_Fi_ShareApp: App {
    @StateObject private var settings = SettingsModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .environmentObject(settings)
        }
    }
}
