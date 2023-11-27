//
//  StatsViewWatch.swift
//  SiestaWatch Watch App
//
//  Created by Sanaa Shahzadi on 24/11/2023.
//

import SwiftUI

struct StatsViewWatch: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Divider()
            HStack {
                Image(systemName: "gamecontroller.fill")
                    .foregroundStyle(.yellow)
                    .frame(width: 30, height: 30, alignment: .center)
                
                Text("CURRENT SCORE: ")
                    .font(.footnote)
                Text("\(UserDefaults.getUserScoreValue())")
            }
            Divider()
            HStack {
                Image(systemName: "trophy.fill")
                    .foregroundStyle(.red)
                    .frame(width: 30, height: 30, alignment: .center)
                
                Text("HIGHEST SCORE: ")
                    .font(.footnote)
                Text("\(UserDefaults.getHighScoreValue())")
            }
            Divider()
        }
    }
}

#Preview {
    StatsViewWatch()
}
