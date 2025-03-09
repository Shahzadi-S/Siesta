//
//  TrackingManager.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 09/03/2025.
//

import Foundation
import AppTrackingTransparency


class TrackingManager {
    func requestATTTracking() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
        if #available(iOS 14, *) {
                    ATTrackingManager.requestTrackingAuthorization { status in
                        switch status {
                            case .authorized:
                                print("🔍 Tracking Enabled")
                            case .denied:
                                print("🔍 Tracking Disabled")
                            default:
                                print("🔍 Tracking Disabled")
                        }
                    }
                }
        })
    }
}
