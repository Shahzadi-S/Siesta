//
//  GameViewModelWatch.swift
//  SiestaWatch Watch App
//
//  Created by Sanaa Shahzadi on 25/11/2023.
//

import Foundation
import WatchKit


class ViewModelWatch {
    
    func playSoundsAndHapticsWatch() {
        let silentModeIsEnabled = UserDefaults.getSilentValue()
        let loudModeIsEnabled = UserDefaults.getLoudValue()
        
        if silentModeIsEnabled {
            // No sound or haptics
        } else if loudModeIsEnabled {
            WKInterfaceDevice.current().play(.start)
        } else {
            WKInterfaceDevice.current().play(.click)
        }
    }
}
