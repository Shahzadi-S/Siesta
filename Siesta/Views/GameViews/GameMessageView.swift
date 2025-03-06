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
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 300, height: 90)
                    .foregroundStyle(.black)
                Text(viewModel.messageText.message)
                    .foregroundStyle(.white)
                    .fontWeight(.thin)
                    .kerning(8.0)
                    .font(.custom("Copperplate", size: 30))
            }
            
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 6)
                .foregroundStyle(.primary)
                .frame(width: 320, height: 120)
                .scaleEffect(animationAmount)
            
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1).repeatForever()) {
                animationAmount = 1.1
            }
            viewModel.handleLoseMessage()
            viewModel.handleWinMessage()
            withAnimation(.linear(duration: 1).delay(3.5)) {
                viewModel.showMessage = false
            }
        }
    }
}

#Preview {
    GameMessageView().environmentObject(ViewModel())
}
