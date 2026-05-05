//
//  MomotoMindmapApp.swift
//  MomotoMindmap
//
//  Created by Ken on 01/05/26.
//

import SwiftUI

@main
struct MomotoMindmapApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
