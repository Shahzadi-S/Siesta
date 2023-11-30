//
//  UserDefaults_extention.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 27/11/2023.
//

import Foundation

// GET STORED VALUES FROM USER DEFAULTS
extension UserDefaults {
    
    // GETS USERS CURRENT SCORE
    static func getUserScoreValue() -> Int {
        return UserDefaults.standard.integer(forKey: Constants.userScoreKey)
    }
    
    // GETS USERS HIGH SCORE - NOT CURRENTLY USED
    static func getHighScoreValue() -> Int {
        return UserDefaults.standard.integer(forKey: Constants.highScoreKey)
    }
    
    // GETS THE VALUE FOR SETTINGS - SILENT MODE
    static func getSilentValue() -> Bool {
        return UserDefaults.standard.bool(forKey: Constants.silentKey)
    }
    
    // GETS THE VALUE FOR SETTINGS - LOUD MODE
    static func getLoudValue() -> Bool {
        return UserDefaults.standard.bool(forKey: Constants.loudKey)
    }
}


// MARK: - CONSTANTS
private extension UserDefaults {
    enum Constants {
        // USER DEFAULT KEYS
        static let userScoreKey = "userScore"
        static let highScoreKey = "highScore"
        static let silentKey = "silentKey"
        static let loudKey = "loudKey"
    }
}
