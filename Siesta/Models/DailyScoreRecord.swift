//
//  DailyScoreRecord.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 05/01/2024.
//

import Foundation

struct DailyScoreRecord: Identifiable {
    let id = UUID()
    let date: String
    var score: Int
}

struct PieChartItem: Identifiable {
    let id = UUID()
    let group: Int
    let total: Int
}
