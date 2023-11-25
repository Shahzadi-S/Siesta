//
//  StatsView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI

struct StatsView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Image(systemName: "gamecontroller.fill")
                    .foregroundStyle(.yellow)
                    .frame(width: 30, height: 30, alignment: .center)
                    .font(.system(size: 40))
                    .padding()
                
                Text("CURRENT SCORE: ")
                    .font(.callout)
                Text("\(UserDefaults.getUserScoreValue())")
            }
            
            HStack {
                Image(systemName: "trophy.fill")
                    .foregroundStyle(.red)
                    .frame(width: 30, height: 30, alignment: .center)
                    .font(.system(size: 40))
                    .padding()
                
                Text("HIGHEST SCORE: ")
                    .font(.callout)
                Text("\(UserDefaults.getHighScoreValue())")
            }
        }
    }
}

#Preview {
    StatsView()
}
