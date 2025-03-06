//
//  HapticsManagers.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 27/11/2023.
//

import UIKit
import AVFoundation

final class HapticsManager {
    
    // SOUND AND HAPTICS SETTINGS
    // RETRIEVES THE VALUES STORED IN USER DEFAULTS FOR SOUND AND HAPTICS
    // THE USER HAS THE OPTION TO TURN VIBRATIONS AND SOUND ON/OFF
    func playSoundsAndVibrations() {
        let vibrationsEnabled = UserDefaults.isVibrationOn
        let soundEnabled = UserDefaults.isSoundOn
        
        let generator = UINotificationFeedbackGenerator()
        
        if isKeyPresentInUserDefaults(key: "vibrationsKey") {
            if soundEnabled {
                generator.notificationOccurred(.success)
                AudioServicesPlaySystemSound(1057)
            } else if (soundEnabled == false) && (vibrationsEnabled == false) {
                // No sound or haptics
            } else if vibrationsEnabled && (soundEnabled == false) {
                generator.notificationOccurred(.success)
            } else {
                generator.notificationOccurred(.success)
            }
        } else {
            generator.notificationOccurred(.success)
            AudioServicesPlaySystemSound(1057)
        }
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}

