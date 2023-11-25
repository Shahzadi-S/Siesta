//
//  SiestaWatchApp.swift
//  SiestaWatch Watch App
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

@main
struct SiestaWatch_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(ViewModel())
        }
    }
}
