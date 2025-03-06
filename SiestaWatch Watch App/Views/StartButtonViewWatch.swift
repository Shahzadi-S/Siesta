//
//  StartButtonViewWatch.swift
//  SiestaWatch Watch App
//
//  Created by Sanaa Shahzadi on 23/11/2023.
//

import SwiftUI

struct StartButtonViewWatch: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            ButtonColorPanelView(isWatch: true)
            ZStack {
                NavigationLink(destination: GameViewWatch()) {
                    Text(" START")
                        .foregroundStyle(.white)
                        .fontWeight(.heavy)
                        .kerning(10.0)
                        .font(.custom("Copperplate", size: 16))
                }
            }
            ButtonColorPanelView(isWatch: true)
        }
    }
}

#Preview {
    StartButtonViewWatch().environmentObject(ViewModel())
}
