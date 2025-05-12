//
//  AdsManager.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 06/03/2025.
//

/// IronSource Ads Code //

import IronSource

class AdsManager: NSObject, ObservableObject, LevelPlayRewardedVideoDelegate {
    
    static let shared = AdsManager()
    
    private let appKey = "21fc971c5"
    private let placement = "Game_Over"
    
    @Published var isAdReady: Bool = false
    
    override init() {
        super.init()
        
        // Prints out the current device's Advertising ID which can be added to the test devices exemption.
        //        print("SANAA: Advertisement ID: \(IronSource.advertiserId())")
        
        // Set up the new delegate for Rewarded Video
        IronSource.setLevelPlayRewardedVideoDelegate(self)
    }
    
    func initializeAdSetup() {
        //        IronSource.setMetaDataWithKey("is_test_suite", value: "enable")
        
        IronSource.initWithAppKey(appKey, adUnits: [IS_REWARDED_VIDEO])
        print("✅ Ads Initialised Successfully.")
    }
    
    // MARK: - Rewarded Video Ads
    func loadAd() {
        IronSource.loadRewardedVideo()
        isAdReady = true // Ad can be shown
        print("⏳ Ads Loaded Successfully.")
    }
    
    func showAdsTestSuite(from viewController: UIViewController) {
        IronSource.launchTestSuite(viewController)
        print("🔍 Launching Test Suite for Ads.")
    }
    
    func showAd(from viewController: UIViewController) {
        guard isAdReady else {
            print("🚨 IronSource Ad is not ready.")
            return
        }
        
        IronSource.showRewardedVideo(with: viewController, placement: placement)
        isAdReady = false // Reset after showing ad
    }
    // MARK: - LevelPlayRewardedVideoDelegate Methods
    
    func hasAvailableAd(with adInfo: ISAdInfo!) {
        isAdReady = true
        print("✅ Ad is available: \(adInfo?.description ?? "Unknown").")
    }
    func hasNoAvailableAd() {
        isAdReady = false
        print("💔 Ad not available.")
    }
    
    func didReceiveReward(forPlacement placementInfo: ISPlacementInfo!, with adInfo: ISAdInfo!) {
        print("💰 Received a reward for watching the Ad.")
    }
    
    func didFailToShowWithError(_ error: (any Error)!, andAdInfo adInfo: ISAdInfo!) {
        print("🚨 Ad failed to show because: \(error.localizedDescription).")
    }
    
    func didOpen(with adInfo: ISAdInfo!) {
        print("👀 Ad video was opened.")
    }
    
    func didClick(_ placementInfo: ISPlacementInfo!, with adInfo: ISAdInfo!) {
        print("👆 Clicked Ad: \(placementInfo?.placementName ?? "Unknown").")
    }
    
    func didClose(with adInfo: ISAdInfo!) {
        print("🌚 Closed Ad.")
        self.loadAd()
    }
}

//import GoogleMobileAds
//
//class AdsManager: NSObject, ObservableObject, FullScreenContentDelegate {
//    private var rewardedAd: RewardedAd?
//
//    func loadAd() async {
//        do {
//            rewardedAd = try await RewardedAd.load(
//                with: "ca-app-pub-8922825973656519/5593151142", request: Request())
//            rewardedAd?.fullScreenContentDelegate = self
//        } catch {
//            print("Failed to load rewarded ad with error: \(error.localizedDescription)")
//        }
//    }
//
//    func showAd() {
//        guard let rewardedAd = rewardedAd else {
//            return print("Ad wasn't ready.")
//        }
//
//        rewardedAd.present(from: nil) {
//            let reward = rewardedAd.adReward
//            print("Reward amount: \(reward.amount)")
//        }
//    }
//
//    // MARK: - GADFullScreenContentDelegate methods
//    func adDidRecordImpression(_ ad: FullScreenPresentingAd) {
//        print("\(#function) called")
//    }
//
//    func adDidRecordClick(_ ad: FullScreenPresentingAd) {
//        print("\(#function) called")
//    }
//
//    func ad(
//        _ ad: FullScreenPresentingAd,
//        didFailToPresentFullScreenContentWithError error: Error
//    ) {
//        print("\(#function) called")
//    }
//
//    func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
//        print("\(#function) called")
//    }
//
//    func adWillDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
//        print("\(#function) called")
//    }
//
//    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
//        print("\(#function) called")
//        // Clear the rewarded ad.
//        rewardedAd = nil
//    }
//}
