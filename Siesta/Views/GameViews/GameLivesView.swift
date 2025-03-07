//
//  GameLivesView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 06/03/2025.
//


import SwiftUI

struct GameLivesView: View {
    let livesCountText: String
    
    var body: some View {
        HStack {
            Image(systemName: "heart.fill")
                .font(.system(size: 24, design: .rounded))
                .foregroundStyle(.red)
            Text(livesCountText)
                .font(.title3)
        }
    }
}

#Preview {
    GameLivesView(livesCountText: "3")
}
