//
//  ReadyView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 18/12/2023.
//

import SwiftUI

struct ReadyView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.foreground)
                .frame(width: 100, height: 100, alignment: .center)
                .padding()
                .font(.system(size: 100))
                .accessibilityHidden(true)
            
            Text("Are you ready?")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Text("Tap to begin.")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
        }
        .accessibilityElement(children: .combine)
        .contentShape(Rectangle())
        .onTapGesture {
            isOnboarding = false
        }
    }
}

#Preview {
    ReadyView()
}
