//
//  TrackingManager.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 09/03/2025.
//

import Foundation
import AppTrackingTransparency


class TrackingManager {
    
    // For users who weren't prompted in 1.0 but have since updated
    func checkATTTrackingStatus() {
        let status = ATTrackingManager.trackingAuthorizationStatus
        switch status {
        case .notDetermined:
            requestATTTracking()
        case .authorized:
            print("✅ Tracking already authorized")
        case .denied:
            print("❌ Tracking previously denied")
        case .restricted:
            print("🔒 Tracking restricted (e.g., parental controls)")
        @unknown default:
            break
        }
    }
    
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
