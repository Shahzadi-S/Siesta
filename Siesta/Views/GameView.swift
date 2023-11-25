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
            ZStack {
        #if os(watchOS)
                GameSquaresViewWatch()
                GameMessageViewWatch()
        #else
                GameSquaresView()
                GameMessageView()
        #endif
            }
        }
    }
}

#Preview {
    GameView().environmentObject(ViewModel())
}
