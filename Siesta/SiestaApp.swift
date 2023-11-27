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


/* Notes for the Siesta App
  
// Seperate the viewModels per view and device instead of having one big one
   Seperation of responsibility is much better if it's all untangled.
 
// App and phone - should they store the same level or not 
 
// Sessions - manage user session if app is backgrounded etc on watch and ios
 
// Accessibility - labels added but need to get flashing color to read out in VO
 
// landscape view - or locked to portrait
// Run on a bunch of different devices to make sure it's all ok
 
 
 DONE!!!
 // check the timer and dispatch queue times and increase them to match
 // increase time for the animation flashing
 // BUG - content view if you tap on square nothing happens - have to tap on text
 // BUG - meant to be untappable when demo is happening
 // Create seperate view or say watchos only for gameSQ gameMSG. For some just add padding etc.
 // Settings view - Add sound and haptics back
 // Settings to have version no.
 
 NOTES!!!!
 
 Half Screen of the game content view
 
 var body: some View {
     VStack(alignment: .center, spacing: 2) {
         Image(colorScheme == .dark ? "bannerDark" : "bannerLight")
             .resizable()
             .frame(width: 200, height: 200, alignment: .center)
             .padding(.top)
         
         NavigationStack {
             VStack {
                 StartButtonView()
                 StatsView()
                 SettingsButtonView()
             }
             .padding(.top, -50)
         }
         .onAppear {
             viewModel.userScore = 0
         }
     }
 }
 
 
 */
