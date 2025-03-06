//
//  StatusMessage.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 24/02/2025.
//

import Foundation

enum Message {
    case yourTurn
    case youWin
    case youLost
    case tryAgain
    case nextLevel
    
    // Should rename these in the future
    var message: String {
        switch self {
        case .yourTurn:
            return "Your Turn"
        case .youWin:
            return "Well Done!"
        case .youLost:
            return "Incorrect"
        case .tryAgain:
            return "Watch Again"
        case .nextLevel:
            return "Next Level"
        }
    }
    
}
