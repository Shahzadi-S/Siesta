//
//  GameMessageView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

struct GameMessageView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var animationAmount = 1.0
    
    var body: some View {
        if viewModel.showMessage {
            Text(viewModel.statusLabel)
                .font(.title2)
                .foregroundStyle(.white)
                .frame(alignment: .center)
                .padding(15)
                .background(RoundedRectangle(cornerRadius: 6.0)
                    .fill(Color.black.opacity(0.7)).shadow(radius: 3))
                .onTapGesture {
                    viewModel.messageWasTapped()
                }
                .accessibilityLabel(viewModel.statusLabel)
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
    GameMessageView().environmentObject(ViewModel())
}
