//
//  GameOverView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 06/03/2025.
//

import GoogleMobileAds
import SwiftUI

struct GameOverView: View {
    @EnvironmentObject var viewModel: ViewModel
    @StateObject private var adsManager = AdsManager()
    @StateObject private var countdownTimer = CountdownTimer(5) // Provided by AdMob
    @State private var beforeAdWatch = true
    
    var body: some View {
        VStack {
            if beforeAdWatch {
                ButtonColorPanelView(isWatch: false)
                VStack {
                    VStack {
                        Text("You ran out of lives")
                        Text("Watch the advert to win more")
                    }
                    .font(.title3)
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 300, height: 100)
                            .foregroundStyle(Color(red: 1, green: 0.569, blue: 0.302))
                        Text(countdownTimer.isComplete ? "WATCH AD ♥️" : "\(countdownTimer.timeLeft)")
                            .fontWeight(.semibold)
                            .kerning(5.0)
                            .font(.title)
                            .foregroundStyle(.white)
                    }.onTapGesture {
                        adsManager.showAd()
                        viewModel.numberOfLives += 3
                        beforeAdWatch = false
                        print("📺 Watching Ad")
                    }
                }
                ButtonColorPanelView(isWatch: false)
            } else {
                ButtonColorPanelView(isWatch: false)
                VStack {
                    VStack {
                        Text("Thanks for Watching ♥️")
                    }
                    .font(.title3)
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 300, height: 100)
                            .foregroundStyle(Color(red: 1, green: 0.569, blue: 0.302))
                        Text("RESUME")
                            .fontWeight(.semibold)
                            .kerning(5.0)
                            .font(.title)
                            .foregroundStyle(.white)
                    }.onTapGesture {
                        viewModel.didRunOutOfLives = false
                        viewModel.startDemo()
                    }
                }.padding(30)
                ButtonColorPanelView(isWatch: false)
            }
        }.onAppear {
            countdownTimer.start()
            Task {
                await adsManager.loadAd()
            }
        }
    }
}

#Preview {
    GameOverView().environmentObject(ViewModel())
}
