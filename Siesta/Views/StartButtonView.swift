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
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 300, height: 100)
                            .foregroundStyle(Color(red: 1, green: 0.569, blue: 0.302))
                            .padding(20)
                        Text(" START")
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .kerning(30.0)
                            .font(.largeTitle)
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
