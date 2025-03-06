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
        VStack {
            NavigationLink(destination: GameView()) {
                VStack {
                    ButtonColorPanelView(isWatch: false)
                        .padding(-7)
                    ZStack {
                        Text(" START")
                            .foregroundStyle(.yellow)
                            .fontWeight(.semibold)
                            .kerning(30.0)
                            .font(.custom("Copperplate", size: 52))
                        Text(" START")
                            .foregroundStyle(.primary)
                            .fontWeight(.semibold)
                            .kerning(30.0)
                            .font(.custom("Copperplate", size: 50))
                    }
                    ButtonColorPanelView(isWatch: false)
                        .padding(-20)
                }
            }
        }
        .accessibilitySortPriority(3)
    }
}

#Preview {
    StartButtonView().environmentObject(ViewModel()
    )
}
