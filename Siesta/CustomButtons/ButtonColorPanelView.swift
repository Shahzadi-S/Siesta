//
//  ButtonColorPanelView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 06/03/2025.
//

import SwiftUI

struct ButtonColorPanelView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var isAnimating: Bool = true
    var isWatch: Bool
    
    var body: some View {
        HStack {
            ForEach(0..<viewModel.themeColors.count, id: \.self) { index in
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(viewModel.themeColors[index])
                    .opacity(0.7)
                    .frame(width: isWatch ? 35 : 75,
                           height: isWatch ? 60 : 200)
                    .scaleEffect(isAnimating ? 0.90 : 1)
            }
        }.onAppear {
            withAnimation(.easeIn(duration: 1.0).repeatForever(autoreverses: true)) {
                isAnimating.toggle()
            }
            
        }
    }
}

#Preview {
    ButtonColorPanelView(isWatch: true).environmentObject(ViewModel())
}
