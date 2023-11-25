//
//  StartButtonView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

struct RoundedButton: ButtonStyle {
    var color: Color
    var font: Font
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .frame(width: 250, height: 70, alignment: .center)
        .background(color.cornerRadius(50.0).opacity(0.2))
        .foregroundStyle(color)
        .font(font)
        
    }
}

struct StartButtonView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack() {
            Button(action: {
                
            }, label: {
                NavigationLink("START", destination: GameView().onAppear {
                    if viewModel.didStartGame {
                        viewModel.status.value = .stopped
                    } else {
                        viewModel.status.value = .demo
                    }
                })
            })
            .buttonStyle(RoundedButton(color: .green, font: .title3))
            
        }
        .padding(20)
    }
}

#Preview {
    StartButtonView()
}
