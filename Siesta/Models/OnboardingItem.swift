//
//  OnboardingItem.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 16/12/2023.
//

import Foundation
import SwiftUI

struct OnboardingItem: Identifiable {
    var id = UUID()
    var count: Int
    var title: String
    var headline: String
}

let onboardingData: [OnboardingItem] = [OnboardingItem(count: 0, title: "Welcome to Siesta", headline: "Time to clear your head."),
                                        OnboardingItem(count: 1, title: "Focus", headline: "Watch the sequence playing on screen."),
                                        OnboardingItem(count: 2, title: "Memorise", headline: "Wait till it's your turn."),
                                        OnboardingItem(count: 3, title: "Play", headline: "Tap each color to repeat the sequence and win."),
                                        OnboardingItem(count: 4, title: "", headline: "")]
