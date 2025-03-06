//
//  GameSquaresView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

struct GameSquaresView: View {
    @EnvironmentObject var viewModel: ViewModel
    var hapticsManager = HapticsManager()
    private let numberOfRows: CGFloat = 2
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                LazyVGrid(columns: columns, spacing: 6) {
                    ForEach(0..<viewModel.themeColors.count, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 6)
                            .fill(viewModel.themeColors[index])
                            .opacity(viewModel.opacities[index])
                            .frame(height: (geo.size.height / numberOfRows).rounded())
                            .allowsHitTesting(viewModel.isTappable)
                            .scaleEffect(viewModel.wiggle ? 0.8 : 1)
                            .onTapGesture {
                                hapticsManager.playSoundsAndVibrations()
                                viewModel.panelTapped(at: index)
                            }
                            .accessibilityHidden(viewModel.demoMode)
                            .accessibilityLabel(viewModel.getColorName(for: viewModel.themeColors[index]))
                        
                            .onAppear {
                                viewModel.startDemo()
                            }
                    }
                }
            }
        }.padding()
    }
}

#Preview {
    GameSquaresView().environmentObject(ViewModel())
}
