//
//  ChartDataManager.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 05/01/2024.
//

import Foundation

final class ChartDataManager {
    
    private var dailyScoreRecords: [DailyScoreRecord] = []
    
    var mockDailyScoreRecords: [DailyScoreRecord] = [DailyScoreRecord(date: "04.01.24", score: 2),
                                                     DailyScoreRecord(date: "05.01.24", score: 1),
                                                     DailyScoreRecord(date: "06.01.24", score: 5),
                                                     DailyScoreRecord(date: "07.01.24", score: 2),
                                                     DailyScoreRecord(date: "10.01.24", score: 2),
                                                     DailyScoreRecord(date: "15.01.24", score: 1)]
    
    @Published var pieChartData: [PieChartItem] = []
    
    func userCreatedNewScore(_ newScore: Int) {
        let today = getTodaysDateAsString()
        
        createRecordOfScore(today: today, newScore: newScore)
        
        let groups = createGroupsOfTheUserScoreRecord()
        
        createPieChartItems(with: groups)
    
    }
    
    // CAPTURES TODAYS DATE IN STRING FORMAT AND RETURNS IT
    private func getTodaysDateAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        let today = formatter.string(from: Date.now)
        return today
    }
    
    // CREATES A NEW RECORD OF THE USER SCORE
    // IF AN ENTRY HAS ALREADY BEEN MADE TODAY, IT IS DELETED
    // AND REPLACED WITH A NEW ENTRY WITH THE LATEST SCORE
    private func createRecordOfScore(today: String, newScore: Int) {
        if dailyScoreRecords.last?.date == today {
            if dailyScoreRecords.last?.score ?? 0 < newScore {
                _ = dailyScoreRecords.popLast()
                let data = DailyScoreRecord(date: today, score: newScore)
                dailyScoreRecords.append(data)
            }
        } else {
            let data = DailyScoreRecord(date: today, score: newScore)
            dailyScoreRecords.append(data)
        }
    }
    
    // SEPERATES THE DATA INTO GROUPS BASED ON THE VALUE OF THE SCORE
    // THE DATA IS STORED IN A DICTIONARY WITH THE KEY BEING 1, 2, 3
    // AND THE VALUE BEING ALL RECORDS OF ACHIEVING THAT SCORE
    private func createGroupsOfTheUserScoreRecord() ->  [Int : [DailyScoreRecord]] {
        var groups = Dictionary(grouping: mockDailyScoreRecords, by: { $0.score } )
        return groups
    }
    
    // FOR EVERY ITEM IN THE GROUPED DICTIONARY
    // LET RECORDS BE AN ARRAY OF USER SCORE RECORDS WITHIN THAN GROUP
    // THEN COUNT THE NUMBER OF RECORDS IN THAT ARRAY
    // STORE THE KEY: 1 WITH COUNT OF 4 OCCURENCES TO PIECHARTDATA
    private func createPieChartItems(with groups: [Int: [DailyScoreRecord]]) {
        for group in groups {
            let records = group.value
            let total = records.count
            let data = PieChartItem(group: group.key, total: total)
            pieChartData.append(data)
        }
    }
}
