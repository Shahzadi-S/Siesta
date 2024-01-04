//
//  StatisticsButtonView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 25/12/2023.
//

import SwiftUI

struct InsightsButtonView: View {
    var body: some View {
        VStack {
            NavigationLink("INSIGHTS", destination: InsightsView())
                .buttonStyle(RoundedButton(color: .blue, font: .title3))
        }
        .padding(20)
    }
}

#Preview {
    InsightsButtonView()
}
