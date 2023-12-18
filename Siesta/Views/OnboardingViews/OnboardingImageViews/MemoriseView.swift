//
//  MemoriseView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 17/12/2023.
//

import SwiftUI

struct MemoriseView: View {
    @State private var animationAmount = 1.0
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.red)
                        .opacity(0.3)
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.green)
                        .opacity(0.3)
                }
                HStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.yellow)
                        .opacity(0.3)
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.blue)
                        .opacity(0.3)
                }
            }.scaledToFit()
            
            VStack {
                Text("Your Turn Now")
                    .font(.title)
                    .foregroundStyle(.white)
                    .frame(alignment: .center)
                    .padding(20)
                    .background(RoundedRectangle(cornerRadius: 15.0)
                        .fill(Color.black.opacity(0.7)).shadow(radius: 3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8.0)
                            .stroke()
                            .scaleEffect(animationAmount)
                            .opacity(2 - animationAmount)
                            .animation(
                                .easeInOut(duration: 2)
                                .repeatForever(),
                                value: animationAmount
                            )
                    ).onAppear {
                        animationAmount = 2
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            animationAmount = 1
                        }
                    }
            }
        }
        .accessibilityHidden(true)
    }
}

#Preview {
    MemoriseView()
}
