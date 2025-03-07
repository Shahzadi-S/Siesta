//
//  GameView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            if viewModel.didRunOutOfLives {
                GameOverView()
                    .navigationBarBackButtonHidden()
            } else {
                ZStack {
                    GameSquaresView()
                    if viewModel.showMessage {
                        GameMessageView()
                    }
                }
                .navigationBarBackButtonHidden(true)
                .toolbarTitleDisplayMode(.inline)
                .toolbar {
                    // MARK: Exit Button
                    ToolbarItem(placement: .topBarTrailing) {
                        ExitGameAlertView()
                    }
                    // MARK: Level/User Score
                    ToolbarItem(placement: .principal) {
                        Text("Level \(UserDefaults.userScoreValue + 1)")
                            .font(.title2)
                            .fontDesign(.monospaced)
                            .fontWeight(.bold)
                    }
                    
                    // MARK: Lives Remaining
                    ToolbarItem(placement: .topBarLeading) {
                        GameLivesView(livesCountText: "\(viewModel.numberOfLives)")
                    }
                }
            }
        }
        
    }
}

#Preview {
    GameView().environmentObject(ViewModel())
}
