//
//  ReviewManager.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 01/12/2023.
//

import StoreKit
import SwiftUI

final class ReviewManager {
    
    // SHOWS THE APPLE FEEDBACK SCREEN TO GIVE STAR RATING OR WRITE REVIEW
    func presentReview() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
}
