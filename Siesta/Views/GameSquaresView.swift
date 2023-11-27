//
//  GameSquaresView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

struct GameSquaresView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            HStack {
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(Color.red)
                    .onTapGesture {
                        viewModel.panelWasTapped(panelColor: .red)
                    }
                    .allowsHitTesting(viewModel.panelEnabled)
                    .opacity(viewModel.redFlashed ? 1 : 0.3)
                    .animation(Animation.linear(duration: 0.5).repeatCount(1), value: viewModel.redFlashed)
                    .padding(3)
                
                
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(Color.green)
                    .onTapGesture {
                        viewModel.panelWasTapped(panelColor: .green)
                    }
                    .allowsHitTesting(viewModel.panelEnabled)
                    .opacity(viewModel.greenFlashed ? 1 : 0.3)
                    .animation(Animation.linear(duration: 0.5).repeatCount(1), value: viewModel.greenFlashed)
                    .padding(3)
                   
            }
            HStack {
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(Color.yellow)
                    .onTapGesture {
                        viewModel.panelWasTapped(panelColor: .yellow)
                    }
                    .allowsHitTesting(viewModel.panelEnabled)
                    .opacity(viewModel.yellowFlashed ? 1 : 0.3)
                    .animation(Animation.linear(duration: 0.5).repeatCount(1), value: viewModel.yellowFlashed)
                    .padding(3)
                
                
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(Color.blue)
                    .onTapGesture {
                        viewModel.panelWasTapped(panelColor: .blue)
                    }
                    .allowsHitTesting(viewModel.panelEnabled)
                    .opacity(viewModel.blueFlashed ? 1 : 0.3)
                    .animation(Animation.linear(duration: 0.5).repeatCount(1), value: viewModel.blueFlashed)
                    .padding(3)
            }
        }
        .padding()
    }
}

#Preview {
    GameSquaresView().environmentObject(ViewModel())
}
