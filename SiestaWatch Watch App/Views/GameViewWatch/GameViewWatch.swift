//
//  GameView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI


struct GameViewWatch: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            GameSquaresViewWatch()
            if viewModel.showMessage {
                GameMessageViewWatch()
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                    viewModel.endGame()
                } label: {
                    Image(systemName: "figure.walk.arrival")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Text("Level: \(UserDefaults.userScoreValue + 1)")
                    .font(.callout)
                    .fontDesign(.monospaced)
                    .fontWeight(.light)
            }
        }
    }
}

#Preview {
    GameViewWatch().environmentObject(ViewModel())
}
