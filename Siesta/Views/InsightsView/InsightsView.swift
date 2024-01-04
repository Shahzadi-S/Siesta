//
//  StatisticsView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 25/12/2023.
//

import SwiftUI
import Charts

struct InsightsView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    
    var body: some View {
        VStack {
            Text("")
                .navigationTitle("Insights")
                .navigationBarTitleDisplayMode(.inline)
            
            var data = viewModel.pieChartData
            
            Chart(data, id: \.id) { element in
                SectorMark(angle:
                        .value("Total", element.total),
                           angularInset: 2.0
                )
                .foregroundStyle(by: .value("Group", element.total))
                .annotation(position: .overlay) {
                    Text("\(element.group)")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
            }
        
        }
    }
}

#Preview {
    InsightsView()
}
