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
#if os(watchOS)
        SessionManagerWatch().startSession()
#else
        UIApplication.shared.isIdleTimerDisabled = true
#endif
    }
    
    // IF USER NAVIGATES AWAY THEN SESSION IS ENDED AND SCREEN CAN DIM
    func stopSession() {
#if os(watchOS)
        SessionManagerWatch().stopSession()
#else
        UIApplication.shared.isIdleTimerDisabled = false
#endif
    }
}
