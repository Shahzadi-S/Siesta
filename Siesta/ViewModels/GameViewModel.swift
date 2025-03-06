//
//  GameViewModel.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI
import StoreKit

final class ViewModel: ObservableObject {
    // Shared between iOS and WatchOS
    
    @Published private var timer: Timer? = nil
    @Published var opacities: [Double] = Array(repeating: 0.1, count: 4)
    @Published private var demoSequencePanelIndex = 0 // Index of the current panel being animated
    @Published var isTappable = false
    @Published var wiggle = false
    @Published var demoMode = false
    @Published var showMessage = false
    @Published var messageText: Message = .youLost {
        didSet {
            announceVoiceOverText(messageText.message)
        }
    }
    let themeColors: [Color] = [.blue, .green, .yellow, .red]
    private var sequence: [Int] = [0, 1, 2, 3]  // The sequence of colors to be animated in order
    private var userGamePlay: [Int] = [] // Indices of colors the user has tapped
    private var userTappedIndex = 0 // Index of the current panel user has tapped
    private let animationDuration: TimeInterval = 2.0 // Duration of fade-in/fade-out cycle
    
    func startDemo() {
        if UserDefaults.userScoreValue > 0 {
            getDemoSequenceFromUserDefaults()
        }
        
        demoMode = true
        isTappable = false
        showMessage = false
        startAnimationSequence()
    }
    
    private func startAnimationSequence() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
                self.animateNextColor()
            }
        }
    }
    
    private func animateNextColor() {
        guard demoSequencePanelIndex < sequence.count else {
            endGame()
            updateMessage(.yourTurn)
            withAnimation(.easeIn(duration: 0.5)) {
                showMessage = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                self.isTappable = true
            }
            return
        }
        
        let indexToAnimate = sequence[demoSequencePanelIndex]
        
#if os(watchOS)
        // WatchOS only due to the Always-On function by Apple
        // Which reduces animations and dims screen
        showNextColor_WatchOS(indexToAnimate: indexToAnimate)
#else
        let colorName = getColorName(for: themeColors[indexToAnimate])
        announceVoiceOverText(colorName)
        showNextColor_iOS(indexToAnimate: indexToAnimate)
#endif
        
    }
    
    private func showNextColor_WatchOS(indexToAnimate: Int) {
        // Change opacity without animation
        
        self.opacities[indexToAnimate] = 1.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.opacities[indexToAnimate] = 0.1
        }
        
        demoSequencePanelIndex += 1
    }
    
    private func showNextColor_iOS(indexToAnimate: Int) {
        // With animation change opacity
        
        withAnimation(.easeIn(duration: 1)) {
            opacities[indexToAnimate] = 1.0
        }
        
        withAnimation(.easeOut(duration: 1).delay(2.0)) {
            opacities[indexToAnimate] = 0.1
        }
        
        demoSequencePanelIndex += 1
    }
    
    func panelTapped(at index: Int) {
        withAnimation(.easeIn(duration: 0.4)) {
            opacities[index] = 1.0
        }
        
        withAnimation(.easeOut(duration: 0.4).delay(0.6)) {
            opacities[index] = 0.1
        }
        
        userGamePlay.append(index)
        verify()
    }
    
    private func verify() {
        if userTappedIndex < sequence.count - 1 {
            if sequence[userTappedIndex] == userGamePlay[userTappedIndex] {
                userTappedIndex += 1
            } else {
                gameLost()
            }
        } else if userTappedIndex == sequence.count - 1 {
            if sequence[userTappedIndex] == userGamePlay[userTappedIndex] {
                // last match
                clearGame()
                generateNewDemoSequence()
                updateMessage(.youWin)
                UserDefaults.userScoreValue += 1
                withAnimation(.easeIn(duration: 0.5).delay(0.6)) {
                    showMessage = true
                }
                print("🏆")
            } else {
                gameLost()
            }
        }
    }
    
    private func gameLost() {
        clearGame()
        updateMessage(.youLost)
        withAnimation(.easeIn(duration: 0.5).delay(0.6)) {
            showMessage = true
        }
        print("💔")
    }
    
    private func clearGame() {
        demoSequencePanelIndex = 0
        userTappedIndex = 0
        userGamePlay = []
        isTappable = false
    }
    
    func endGame() {
        clearGame()
        showMessage = false
        timer?.invalidate()
        timer = nil
        demoMode = false
    }
    
    func handleLoseMessage() {
        if messageText == .youLost {
            withAnimation(.linear(duration: 0.2).delay(2.0)) {
                messageText = .tryAgain
            } completion: {
                withAnimation(.linear(duration: 0.4).delay(4.0)) {
                    self.startDemo()
                }
            }
        }
    }
    
    func handleWinMessage() {
        if messageText == .youWin {
            withAnimation(.linear(duration: 0.2).delay(0.2)) {
                opacities[0] = 0.3
                opacities[1] = 0.3
                opacities[2] = 0.3
                opacities[3] = 0.3
                wiggle = true
            }
            completion: {
                withAnimation(.linear(duration: 0.2).delay(1.5)) {
                    self.wiggle = false
                    self.opacities[0] = 0.1
                    self.opacities[1] = 0.1
                    self.opacities[2] = 0.1
                    self.opacities[3] = 0.1
                }
            }
            
            withAnimation(.linear(duration: 0.2).delay(2.0)) {
                messageText = .nextLevel
            } completion: {
                withAnimation {
                    self.startDemo()
                }
            }
        }
    }
    
    private func generateNewDemoSequence() {
        let randomInt = Int.random(in: 0...3)
        sequence.append(randomInt)
        sequence.shuffle()
        storeSequenceToUserDefaults()
    }
}

// MARK: - EXTENSION - User Defaults Get/Set Sequence Methods
extension ViewModel {
    private func getDemoSequenceFromUserDefaults() {
        do {
            if let data = UserDefaults.standard.data(forKey: Constants.gameSequenceKey) {
                let array = try JSONDecoder().decode([Int].self, from: data)
                sequence = array
            }
        } catch {
            print("🚨 \(error)")
        }
    }
    
    private func storeSequenceToUserDefaults() {
        let data = try! JSONEncoder().encode(sequence)
        UserDefaults.standard.set(data, forKey: Constants.gameSequenceKey)
        print("💾 Sequence")
    }
}

// MARK: - EXTENSION - Voice Over Methods
extension ViewModel {
    private func updateMessage(_ newMessage: Message) {
        messageText = newMessage
        // Ensure message is announced even if it's the same as before
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.announceVoiceOverText(newMessage.message)
        }
    }
    
    private func announceVoiceOverText(_ message: String) {
#if os(iOS)
        UIAccessibility.post(notification: .announcement, argument: message)
#endif
    }
}

// MARK: - EXTENSION - GetColorName for Voice Over
extension ViewModel {
    func getColorName(for color: Color) -> String {
        switch color {
        case .red: return "Red"
        case .green: return "Green"
        case .blue: return "Blue"
        case .yellow: return "Yellow"
        default: return ""
        }
    }
}

// MARK: - CONSTANTS
private extension ViewModel {
    enum Constants {
        static let gameSequenceKey = "gameSequence"
    }
}
