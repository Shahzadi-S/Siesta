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
        let vibrationsEnabled = UserDefaults.getVibrationValue()
        let soundEnabled = UserDefaults.getSoundValue()
        
        let generator = UINotificationFeedbackGenerator()
        
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
    }
}
