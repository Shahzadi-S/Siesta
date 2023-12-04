//
//  SessionManagerWatch.swift
//  SiestaWatch Watch App
//
//  Created by Sanaa Shahzadi on 28/11/2023.
//

import Foundation
import WatchKit

class SessionManagerWatch: NSObject, WKExtendedRuntimeSessionDelegate {
    func extendedRuntimeSession(_ extendedRuntimeSession: WKExtendedRuntimeSession, didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason, error: Error?) {
        print("Session stopped at", Date())
    }
    
    func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        print("Session started at", Date())
    }
    
    func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) { }
    
    private var session = WKExtendedRuntimeSession()
    
    // Check to see current session status before being toggled
    var sessionIsActive = false
    
    // App needs to remain active whilst sequence is playing
    func startSession() {
        if sessionIsActive == false {
            session = WKExtendedRuntimeSession()
            session.delegate = self
            session.start()
            sessionIsActive = true
        }
    }
    
    // App no longer needs to remain active
    func stopSession() {
        if sessionIsActive {
            session.invalidate()
            sessionIsActive = false
        }
    }
}
