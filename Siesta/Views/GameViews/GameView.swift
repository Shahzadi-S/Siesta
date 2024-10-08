//
//  GameView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ZStack {
                GameSquaresView()
                GameMessageView()
            }
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase != .active {
                self.presentationMode.wrappedValue.dismiss()
                viewModel.sessionManager.stopSession()
            }
        }
    }
}

#Preview {
    GameView().environmentObject(ViewModel())
}
