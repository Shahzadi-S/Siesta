//
//  GameSquareViewWatch.swift
//  SiestaWatch Watch App
//
//  Created by Sanaa Shahzadi on 24/11/2023.
//

import SwiftUI

struct GameSquaresViewWatch: View {
    @EnvironmentObject var viewModel: ViewModel
    var hapticsManager = HapticsManagerWatch()
    private let numberOfRows: CGFloat = 2
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
            VStack {
                TimelineView(.periodic(from: .now, by: 0.2)) { context in
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
                            }
                        }
                    }
                }
            }
            .padding()
            .onAppear {
                viewModel.startDemo()
            }
    }
}

#Preview {
    GameSquaresViewWatch().environmentObject(ViewModel())
}
