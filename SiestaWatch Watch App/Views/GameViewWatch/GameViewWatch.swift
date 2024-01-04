//
//  GameView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

struct GameViewWatch: View {
    @EnvironmentObject var viewModel: ViewModelWatch
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ZStack {
                GameSquaresViewWatch()
                GameMessageViewWatch()
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
    GameViewWatch().environmentObject(ViewModelWatch())
}
