//
//  OnboardingView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 17/12/2023.
//

import SwiftUI

struct OnboardingView: View {
    var onboarding: [OnboardingItem] = onboardingData
    
    var body: some View {
        TabView() {
            ForEach(onboarding[0...4]) { item in
                OnboardingCardView(onboarding: item)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .padding(.vertical, 20)
        .tint(.black)
    }
}

#Preview {
    OnboardingView()
}
