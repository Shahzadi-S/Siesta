//
//  ReviewManager.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 01/12/2023.
//

import StoreKit
import SwiftUI

final class ReviewManager {
    
    @AppStorage("lastVersionPromptedForReview") var lastVersionPromptedForReview = ""
    
    // FOR WHEN THE USER TAPS THE BUTTON TO REQUEST A REVIEW
    func requestReviewManually() {
        let url = "https://apps.apple.com/app/id6474789649?action=write-review"
        guard let writeReviewURL = URL(string: url)
        else { fatalError("Expected a valid URL") }
        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
    
    // REQUESTS THE USER TO LEAVE A REVIEW ON THE APPSTORE
    func requestReview() {
        // Checks what the current user score is. This should only appear if the score is 15+
        let currentScore = UserDefaults.userScoreValue
        guard currentScore > 2 else { return }
        
        // Gets the current app version
        let infoDictionaryKey = kCFBundleVersionKey as String
        guard let currentAppVersion = Bundle.main.object(forInfoDictionaryKey: infoDictionaryKey) as? String
        else { fatalError("Expected to find a bundle version in the info dictionary") }
        
        // Checks the last tiem a review was requested, and if it was for the same version
        // If it's a different version then the review screen is presented
        // The last Version Prompted For Review is updated
        if currentAppVersion != lastVersionPromptedForReview {
            presentReview()
            lastVersionPromptedForReview = currentAppVersion
        }
    }
    
    // SHOWS THE APPLE FEEDBACK SCREEN TO GIVE STAR RATING OR WRITE REVIEW
    func presentReview() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
}
