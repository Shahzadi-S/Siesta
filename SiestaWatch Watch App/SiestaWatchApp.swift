//
//  SiestaWatchApp.swift
//  SiestaWatch Watch App
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

@main
struct SiestaWatch_Watch_AppApp: App {
    @State private var selectedTab = 2
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedTab) {
                SettingsViewWatch()
                    .tag(1)
                ContentView().environmentObject(ViewModel())
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
}
