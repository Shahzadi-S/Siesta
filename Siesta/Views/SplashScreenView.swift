//
//  SplashScreenView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 06/03/2025.
//

import SwiftUI

struct SplashScreenView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var animationValue = 1.0
    
    var body: some View {
        VStack {
            Image(colorScheme == .dark ? "bannerDark" : "bannerLight")
                .resizable()
                .frame(width: 500, height: 500, alignment: .center)
                .scaleEffect(animationValue)
                .opacity(animationValue)
                .accessibilityHidden(true)
        }
        .onAppear {
            withAnimation(.spring(duration: 2.0)) {
                animationValue = 0.1
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
