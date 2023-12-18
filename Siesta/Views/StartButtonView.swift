//
//  StartButtonView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

struct StartButtonView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack() {
            NavigationLink("START", destination: GameView().onAppear {
                if viewModel.didStartGame {
                    viewModel.status.value = .stopped
                } else {
                    viewModel.status.value = .demo
                }
            })
            .buttonStyle(RoundedButton(color: .green, font: .title3))
            .accessibilitySortPriority(3)
        }
        .padding(20)
    }
}

#Preview {
    StartButtonView()
}
