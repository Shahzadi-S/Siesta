//
//  StartButtonViewWatch.swift
//  SiestaWatch Watch App
//
//  Created by Sanaa Shahzadi on 23/11/2023.
//

import SwiftUI

struct StartButtonViewWatch: View {
    @EnvironmentObject var viewModel: ViewModelWatch
    
    var body: some View {
        VStack() {
            NavigationLink("Start", destination: GameViewWatch().onAppear {
                if viewModel.didStartGame {
                    viewModel.status.value = .stopped
                } else {
                    viewModel.status.value = .demo
                }
            })
            .padding()
            .tint(.green)
        }
    }
}

#Preview {
    StartButtonViewWatch()
}
