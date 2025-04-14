//
//  ContentView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @State private var isLoading: Bool = true
    private var reviewManager = ReviewManager()
    var trackingManager: TrackingManager = TrackingManager()
    var notificationManager: NotificationManager = NotificationManager()
    
    var body: some View {
        ZStack {
            if self.isLoading {
                SplashScreenView()
            } else {
                NavigationStack {
                    Spacer()
                    VStack {
                        StartButtonView()
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            SettingsButtonView()
                                .padding(5)
                        }
                    }
                    Spacer()
                    Text("Level: \(UserDefaults.userScoreValue + 1)")
                        .font(.callout)
                        .fontDesign(.monospaced)
                        .fontWeight(.light)
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.linear(duration: 2)) {
                    self.isLoading = false
                }
            }
            reviewManager.requestReview()
            trackingManager.checkATTTrackingStatus()
            notificationManager.checkNotificationPermissionStatus()
        }
    }
}

#Preview {
    ContentView().environmentObject(ViewModel())
}
