//
//  GameMessageViewWatch.swift
//  SiestaWatch Watch App
//
//  Created by Sanaa Shahzadi on 24/11/2023.
//

import SwiftUI

struct GameMessageViewWatch: View {
    @EnvironmentObject var viewModel: ViewModelWatch
    
    @State private var animationAmount = 1.0
    
    var body: some View {
        if viewModel.showMessage {
            Text(viewModel.statusLabel)
                .frame(alignment: .center)
                .padding(10.0)
                .background(RoundedRectangle(cornerRadius: 6.0).fill(Color.black.opacity(0.5)).shadow(radius: 3))
                .onTapGesture {
                    viewModel.messageWasTapped()
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 6.0)
                        .stroke(.white)
                        .scaleEffect(animationAmount)
                        .opacity(2 - animationAmount)
                        .animation(
                            .easeInOut(duration: 1)
                            .repeatCount(1, autoreverses: false),
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
}


#Preview {
    GameMessageViewWatch().environmentObject(ViewModelWatch())
}
