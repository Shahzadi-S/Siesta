//
//  StatisticsButtonView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 25/12/2023.
//

import SwiftUI

struct HistoryButtonView: View {
    var body: some View {
        VStack {
            NavigationLink("HISTORY", destination: HistoryView())
                .buttonStyle(RoundedButton(color: .blue, font: .title3))
        }
        .padding(20)
    }
}

#Preview {
    HistoryButtonView()
}

// or insights or statistics or progress 
