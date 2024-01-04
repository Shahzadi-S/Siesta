//
//  SessionCoordinator.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 28/11/2023.
//

import UIKit

class SessionManager {
    
    // STOPS THE SCREEN FOR TIMING OUT WHEN THIS IS ACTIVE
    func startSession() {
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    // IF USER NAVIGATES AWAY THEN SESSION IS ENDED AND SCREEN CAN DIM
    func stopSession() {
        UIApplication.shared.isIdleTimerDisabled = false
    }
}
