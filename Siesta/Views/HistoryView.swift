//
//  StatisticsView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 25/12/2023.
//

import SwiftUI
import Charts

struct HistoryItem: Identifiable {
    var id = UUID()
    var date: String
    var score: Int
}

struct HistoryView: View {
    let data: [HistoryItem] = [HistoryItem(date: "Jan24", score: 3),
                               HistoryItem(date: "Feb24", score: 1),
                               HistoryItem(date: "March24", score: 6)]
    
    var body: some View {
        VStack {
            Text("")
                .navigationTitle("History")
                .navigationBarTitleDisplayMode(.inline)
        
            List {
                Chart(data) {
                    LineMark(x: .value("Date", $0.date),
                             y: .value("Score", $0.score))
                    
                    PointMark(x: .value("Date", $0.date),
                              y: .value("Score", $0.score))
                }
                .frame(height: 200)
            }
        }
    }
}

#Preview {
    HistoryView()
}
