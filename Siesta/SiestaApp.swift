//
//  SiestaApp.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

@main
struct SiestaApp: App {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    var body: some Scene {
        WindowGroup { 
            if isOnboarding {
                OnboardingView().environmentObject(ViewModel())
          } else {
              ContentView().environmentObject(ViewModel())
          }
        }
    }
}


// clean up code and reuse
// accessibility on onboarding 
