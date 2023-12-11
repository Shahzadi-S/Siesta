//
//  SessionManagerWatch.swift
//  SiestaWatch Watch App
//
//  Created by Sanaa Shahzadi on 28/11/2023.
//

import Foundation
import WatchKit

final class SessionManagerWatch: NSObject, WKExtendedRuntimeSessionDelegate {
    
    // DELEGATE METHODS THAT ARE REQUIRED WHEN WORKING WITH WATCH SESSIONS
    func extendedRuntimeSession(_ extendedRuntimeSession: WKExtendedRuntimeSession, didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason, error: Error?) {
        print("Session stopped at", Date())
    }
    
    func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        print("Session started at", Date())
    }
    
    func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) { }
    
    private var session = WKExtendedRuntimeSession()
    
    // CHECK TO SEE CURRENT SESSION STATUS BEFORE TOGGLING
    var sessionIsActive = false
    
    // APP REMAINS ACTIVE WHILST USER IS PLAYING
    func startSession() {
        if sessionIsActive == false {
            session = WKExtendedRuntimeSession()
            session.delegate = self
            session.start()
            sessionIsActive = true
        }
    }
    
    // APP NO LONGER NEEDS TO REMAIN ACTIVE
    func stopSession() {
        if sessionIsActive {
            session.invalidate()
            sessionIsActive = false
        }
    }
}
