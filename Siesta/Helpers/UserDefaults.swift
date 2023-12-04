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
    
    // GETS THE VALUE FOR VIBRATION SETTINGS
    static func getVibrationValue() -> Bool {
        return UserDefaults.standard.bool(forKey: Constants.vibrationsKey)
    }
    
    // GETS THE VALUE FOR SOUND SETTINGS
    static func getSoundValue() -> Bool {
        return UserDefaults.standard.bool(forKey: Constants.soundKey)
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
        static let vibrationsKey = "vibrationsKey"
        static let soundKey = "soundKey"
    }
}
