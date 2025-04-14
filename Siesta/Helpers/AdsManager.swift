//
//  AdsManager.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 06/03/2025.
//

import GoogleMobileAds

class AdsManager: NSObject, ObservableObject, FullScreenContentDelegate {
    private var rewardedAd: RewardedAd?
    
    func loadAd() async {
        do {
            rewardedAd = try await RewardedAd.load(
                with: "ca-app-pub-8922825973656519/5593151142", request: Request())
            rewardedAd?.fullScreenContentDelegate = self
        } catch {
            print("Failed to load rewarded ad with error: \(error.localizedDescription)")
        }
    }
    
    func showAd() {
        guard let rewardedAd = rewardedAd else {
            return print("Ad wasn't ready.")
        }
        
        rewardedAd.present(from: nil) {
            let reward = rewardedAd.adReward
            print("Reward amount: \(reward.amount)")
        }
    }
    
    // MARK: - GADFullScreenContentDelegate methods
    func adDidRecordImpression(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adDidRecordClick(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func ad(
        _ ad: FullScreenPresentingAd,
        didFailToPresentFullScreenContentWithError error: Error
    ) {
        print("\(#function) called")
    }
    
    func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adWillDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
        // Clear the rewarded ad.
        rewardedAd = nil
    }
}
