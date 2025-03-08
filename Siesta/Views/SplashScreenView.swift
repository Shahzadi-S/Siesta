//
//  SplashScreenView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 06/03/2025.
//

import SwiftUI

struct SplashScreenView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @State private var isAnimating: Bool = true
    
    var body: some View {
        VStack(alignment: .center, spacing: -10) {
            ForEach(0..<viewModel.themeColors.count, id: \.self) { index in
                HStack {
                    ForEach(0..<viewModel.themeColors.count, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(viewModel.themeColors[index])
                            .opacity(isAnimating ? 0.7 : 0)
                            .frame(width: 75,
                                   height: 200)
                            .scaleEffect(isAnimating ? 0.50 : 3)
                    }
                }
            }.onAppear {
                withAnimation(.easeIn(duration: 2.0)) {
                    isAnimating.toggle()
                }
                
            }
        }
    }
}

#Preview {
    SplashScreenView().environmentObject(ViewModel())
}
