//
//  GameMessageViewWatch.swift
//  SiestaWatch Watch App
//
//  Created by Sanaa Shahzadi on 24/11/2023.
//

import SwiftUI

struct GameMessageViewWatch: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var animationAmount = 1.0
    
    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 150, height: 50)
                    .foregroundStyle(.black)
                Text(viewModel.messageText.message)
                    .foregroundStyle(.white)
                    .fontWeight(.thin)
                    .kerning(3.0)
                    .font(.custom("Copperplate", size: 16))
            }
            
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 6)
                .foregroundStyle(.primary)
                .frame(width: 150, height: 60)
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
    GameMessageViewWatch().environmentObject(ViewModel())
}
