//
//  SessionCoordinator.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 28/11/2023.
//

import Foundation
import UIKit

class SessionCoordinator {
    
    func startSession() {
        #if os(watchOS)
        SessionManagerWatch().startSession()
        #else
        UIApplication.shared.isIdleTimerDisabled = true
        #endif
    }
    
    func stopSession() {
        #if os(watchOS)
        SessionManagerWatch().stopSession()
        #else
        UIApplication.shared.isIdleTimerDisabled = false
        #endif
    }
}
