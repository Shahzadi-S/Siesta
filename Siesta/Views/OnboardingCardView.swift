//
//  OnboardingCardView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 16/12/2023.
//

import SwiftUI

struct OnboardingCardView: View {
    @State private var isAnimating: Bool = false
    var onboarding: OnboardingItem
    
    var body: some View {
        ZStack {
            VStack {
                switch onboarding.count {
                case 0:
                    Image("logoCircle")
                        .resizable()
                        .scaledToFit()
                case 1:
                    FocusView()
                case 2:
                    MemoriseView()
                case 3:
                    PlayView()
                case 4:
                    ReadyView()
                default:
                    ReadyView()
                }
                
                Text(onboarding.title)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                Text(onboarding.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: 480)
                
            }
        }.onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimating = true
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .cornerRadius(20)
        .padding(.horizontal, 20)
    }
}

#Preview {
    OnboardingCardView(onboarding: onboardingData[0])
}
