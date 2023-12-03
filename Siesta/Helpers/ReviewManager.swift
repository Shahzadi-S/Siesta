//
//  ReviewManager.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 01/12/2023.
//

import Foundation
import StoreKit
import SwiftUI

class ReviewManager {
    
    func presentReview() {
        #if os(iOS)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
            }
        #endif
    }
}
