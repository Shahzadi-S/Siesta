//
//  ContentView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
            NavigationStack {
                Spacer() 
                Image(colorScheme == .dark ? "bannerDark" : "bannerLight")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                    .accessibilityHidden(true)
                
                Spacer()
                
                VStack {
                    StartButtonView()
                    StatsView()
                    SettingsButtonView()
                }
                
                Spacer()
                
            }
            .onAppear {
                viewModel.userScore = 0
                viewModel.requestReview()
            }
    }
}

#Preview {
    ContentView().environmentObject(ViewModel())
}
