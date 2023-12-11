//
//  SiestaApp.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

@main
struct SiestaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(ViewModel())
        }
    }
}


// Refactor settings to reuse the list items
// Look at notifications again - see stash
// Testing strategy of all the features.
