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

// Refactor settings to have vibrations and sound mode 
// Make methods and classes private/final/static etc
// Testing strategy of all the features. 
