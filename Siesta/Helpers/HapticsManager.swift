//
//  HapticsManagers.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 27/11/2023.
//

import Foundation
import UIKit
import AVFoundation

class HapticsManager {
    
    // SOUND AND HAPTICS SETTINGS
    // RETRIEVES THE VALUES STORED IN USER DEFAULTS FOR SOUND AND HAPTICS
    // THE USER HAS THE OPTION FOR DEFAULT, LOUR OR SILENT MODE
    func playSoundsAndHaptics() {
        let silentModeIsEnabled = UserDefaults.getSilentValue()
        let loudModeIsEnabled = UserDefaults.getLoudValue()
        
        #if os(watchOS)
            ViewModelWatch().playSoundsAndHapticsWatch()
        #else
        let generator = UINotificationFeedbackGenerator()
        if silentModeIsEnabled {
            // No sound or haptics
        } else if loudModeIsEnabled {
            generator.notificationOccurred(.success)
            AudioServicesPlaySystemSound(1057)
        } else {
            generator.notificationOccurred(.success)
        }
            
        #endif
    }
}

/*
 
 vibrations of by default. if off then silent mode.
 sound off by default. if on then vibrations are also on. 
 
 */
