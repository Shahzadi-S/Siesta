//
//  UserDefaults_extention.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 27/11/2023.
//

import Foundation


extension UserDefaults {
    // SHARED WITH WATCH APP
    
    static var userScoreValue: Int {
        get {
            UserDefaults.standard.integer(forKey: Constants.userScoreKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Constants.userScoreKey)
        }
    }
    
    static var isVibrationOn: Bool {
        get {
            UserDefaults.standard.bool(forKey: Constants.vibrationsKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Constants.vibrationsKey)
        }
    }
    
    static var isSoundOn: Bool {
        get {
            UserDefaults.standard.bool(forKey: Constants.soundKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Constants.soundKey)
        }
    }

}


// MARK: - CONSTANTS
private extension UserDefaults {
    enum Constants {
        static let userScoreKey = "userScore"
        static let vibrationsKey = "vibrationsKey"
        static let soundKey = "soundKey"
    }
}
