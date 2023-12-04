//
//  GameViewModelWatch.swift
//  SiestaWatch Watch App
//
//  Created by Sanaa Shahzadi on 25/11/2023.
//

import Foundation
import WatchKit


class ViewModelWatch {
    
    func playSoundsAndVibrationsWatch() {
        let vibrationsEnabled = UserDefaults.getVibrationValue()
        let soundEnabled = UserDefaults.getSoundValue()
        
        if soundEnabled {
            WKInterfaceDevice.current().play(.start)
        } else if (soundEnabled == false) && (vibrationsEnabled == false) {
            // No sound or haptics
        } else if vibrationsEnabled && (soundEnabled == false) {
            WKInterfaceDevice.current().play(.click)
        } else {
            WKInterfaceDevice.current().play(.click)
        }
    }
}
