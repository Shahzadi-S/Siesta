//
//  HapticsManagerWatch.swift
//  SiestaWatch Watch App
//
//  Created by Sanaa Shahzadi on 04/01/2024.
//

import WatchKit

final class HapticsManagerWatch {
    // PLAYS SOUNDS AND VIBRATIONS BASED ON USER SETTINGS
    func playSoundsAndVibrations() {
        let vibrationsEnabled = UserDefaults.isVibrationOn
        let soundEnabled = UserDefaults.isSoundOn
        
        if isKeyPresentInUserDefaults(key: "vibrationsKey") {
            if soundEnabled {
                WKInterfaceDevice.current().play(.start)
            } else if (soundEnabled == false) && (vibrationsEnabled == false) {
                // No sound or haptics
            } else if vibrationsEnabled && (soundEnabled == false) {
                WKInterfaceDevice.current().play(.click)
            } else {
                WKInterfaceDevice.current().play(.click)
            }
        } else {
            WKInterfaceDevice.current().play(.start)
        }
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
