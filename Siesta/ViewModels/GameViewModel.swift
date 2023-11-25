//
//  GameViewModel.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import Foundation
import SwiftUI
//import WatchKit
import Combine

class ViewModel: ObservableObject {
    
//    let coordinator = SessionCoordinator()
    
    // MARK: - USING COMBINE
    // Using Combine's CurrentValueSubject to pass the state as a value
    var status = CurrentValueSubject<StatusType, Error>(.start)
    
    // Cancellables ensure subsciptions are stored if a view is recreated
    // but can be removed aka cancelled at a later time to release memory
    // Therefore storing them prevents accidental memory leaks
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - USING USERDEFAULTS
    // SwiftUI uses appStorage for User Default similarly to an ObservableObject
    // Any changes to the value are automatically stored and can reload the view
    let userDefaults = UserDefaults.standard
    @AppStorage("userScore") var userScore = 0
    @AppStorage("highScore") var highScore = 0
    
    // MARK: - GAME SEQUENCE FUNCTIONALITY
    
    var timer: Timer?
    
    // THE COLORS OPTIONS USED TO CREATE THE RANDOM DEMO SEQUENCE
    var colorOptions: [PanelColor] = [.red, .green, .yellow, .blue]
    
    // THE DEMO SEQUENCE WHICH WILL BE FLASHED
    var sequence: [PanelColor] = [.red, .green, .yellow, .blue]
    
    // THE SEQUENCE OF COLORS THAT THE USER HAS SELECTED
    var userInput: [PanelColor] = []
    
    var currentIndexOfSequence = 0
    
    
    @Published var redFlashed = false
    @Published var greenFlashed = false
    @Published var yellowFlashed = false
    @Published var blueFlashed = false
    
    @Published var panelEnabled = false
    
    @Published var statusLabel = ""
    
    @Published var didStartGame = false
    @Published var showMessage = false
    
    
    //MARK: -  SUBSCRIBING TO THE CURRENTVALUESUBJECT
    init() {
        addSubscriptions()
    }
    
    func addSubscriptions() {
        status
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Completion Finished and Received")
                case .failure(let error):
                    print("Completion Failed with Error: \(error)")
                }
            } receiveValue: { status in
                switch status {
                case .start:
                    self.startGame()
                case .demo:
                    self.demoMode()
                case .yourTurn:
                    self.yourTurnMessageIsShown()
                case .playing:
                    break
                case .success:
                    self.userIsSuccessfull()
                case .failed:
                    self.userDidFail()
                case .score:
                    self.userScoreMessageIsShown()
                case .again:
                    self.tryAgainMessageIsShown()
                case .stopped:
                    self.stoppedGame()
                case .resume:
                    self.resumeGame()
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - START GAME
    // Is called before the game has started as the .start status is set be default
    // It checks if a user has already played and retrieves the last sequence the user was shown
    func startGame() {
        if UserDefaults.getUserScoreValue() >= 1 {
            getDemoSequenceFromUserDefaults()
        }
    }
    
    // MARK: - DEMO SEQUENCE IS STARTED
    // In charge of starting the game demo sequence
    // which then proceeds to flash the next colour in the sequence
    // and finally ends the sequence before telling the user it's their turn now.
    func demoMode() {
        didStartGame = true
//        coordinator.startSession()
        gameDemoSequenceStarted()
    }
    
    // MARK: - YOUR TURN MESSAGE IS SHOWN
    // Tells the user they need to start selecting panels
    // Allows the user to play the game by enabling the panels
    func yourTurnMessageIsShown() {
        showMessage = true
        statusLabel = Constants.yourTurnText
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showMessage = false
            self.status.value = .playing
            self.panelEnabled = true
        }
    }
    
    // MARK: - USER IS SUCCESSFULL
    // The success path is started here
    // The next sequence is generated and stored to user defaults
    // The users previous activity is cleared and the current score is incremented
    // The well done message is shown
    func userIsSuccessfull() {
        panelEnabled = false
        turnAllPanelsOff()
        generateNextSequenceAndStoreToUserDefaults()
        
        userInput = []
        userScore += 1
        if hasCreatedNewHighScore(userScore) {
            highScore = userScore
        }
        
        wellDoneMessageIsShown()
    }
    
    // MARK: - USER FAILED
    // The user selected the wrong panel
    // Their previous activity is cleared and you lost message is shown
    func userDidFail() {
        panelEnabled = false
        userInput = []
        youLoseMessageIsShown()
    }
    
    // MARK: - WELL DONE MESSAGE IS SHOWN
    // User is shown the well done message
    // After a delay the users new score is shown
    func wellDoneMessageIsShown() {
        showMessage = true
        statusLabel = Constants.successText
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.status.value = .score
        }
    }
    
    // MARK: - YOU LOSE MESSAGE IS SHOWN
    // User is told they have lost
    // after a delay they are shown the try again message which they can tap
    func youLoseMessageIsShown() {
        showMessage = true
        statusLabel = Constants.failedText
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.status.value = .again
        }
    }
    
    // MARK: - USER SCORE MESSAGE IS SHOWN
    // User is told their current score as per the value stored in UserDefaults
    // After the message the next demo is started immediately.
    func userScoreMessageIsShown() {
        showMessage = true
        statusLabel = "Score is: \(userScore)"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showMessage = false
            self.status.value = .demo
        }
    }
    
    // MARK: - TRY AGAIN MESSAGE IS SHOWN
    // If the user has lost they are shown the try again message
    // If tapped a the same demo is played again
    func tryAgainMessageIsShown() {
        showMessage = true
        statusLabel = Constants.tryAgainText
    }
    
    // MARK: - MESSAGE WAS TAPPED
    // Only the try again message can be tapped
    // if it is tapped the message is turned off and the demo is started
    func messageWasTapped() {
        if status.value == .again {
            showMessage = false
            self.status.value = .demo
        } else {
            return
        }
    }
    
    // MARK: - GAME WAS STOPPED
    // All activity is stopped e.g. timer and panel flashing
    // All values are reset e.g. message, labels, indexOfsequence
    // Method is called when a user returns from inactive or background state
    // Therefore the game can be immediately resumed
    func stoppedGame() {
//        coordinator.stopSession()
        timer?.invalidate()
        currentIndexOfSequence = sequence.count
        turnAllPanelsOff()
        userInput = []
        showMessage = false
        statusLabel = ""
        currentIndexOfSequence = 0
        
        status.value = .resume
        
    }
    
    // MARK: - RESUME GAME
    // If a user returns after stopping a game, it is resumed
    // The last sequence is retrieved if the user had managed to complete the first level
    // The demo of the last sequence is played
    func resumeGame() {
        if UserDefaults.getUserScoreValue() >= 1 {
            getDemoSequenceFromUserDefaults()
        }
        
        self.status.value = .demo
        
    }
    
    // MARK: - USER TAPPED A PANEL
    // Checks the sound and haptics settings in user defaults
    // Tracks when a user has actually started playing and stores the input
    // Matches the input with the stored sequence
    func panelWasTapped(panelColor: PanelColor) {
//        playSoundsAndHaptics()
        flashNextColor(panelColor)
        userInput.append(panelColor)
        validateUserInput()
    }
    
    // MARK: - INPUT VALIDATION
    // Checks what the user has tapped on against the stored sequence array
    // if correct then checks if the entire sequence has been completed
    // if it has it starts the success journey
    // if the user has tapped incorrectly then the fail journey starts
    func validateUserInput() {
        if userInput.last == sequence[userInput.endIndex-1] {
            if userInput.count == sequence.count {
                status.value = .success
                panelEnabled = false
            }
        } else {
            panelEnabled = false
            status.value = .failed
            turnAllPanelsOff()
        }
    }
}

// MARK: - EXTENTION - DEMO SEQUENCE LOGIC
extension ViewModel {
    
    // TIMER IS STARTED TO START PLAYING THE DEMO SEQUENCE
    func gameDemoSequenceStarted() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(newColorInDemoSequence), userInfo: nil, repeats: true)
    }
    
    // RETRIEVES AND FLASHES EACH COLOR FROM THE SEQUENCE
    @objc func newColorInDemoSequence() {
        if currentIndexOfSequence >= sequence.count {
            demoSequenceEnded()
        } else {
            let nextColor = sequence[currentIndexOfSequence]
            turnAllPanelsOff()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.flashNextColor(nextColor)
            }
            
            currentIndexOfSequence += 1
        }
    }
    
    // ENDS THE TIMER FOR THE DEMO SO THE USER CAN START PLAYING
    func demoSequenceEnded() {
//        coordinator.stopSession()
        timer?.invalidate()
        turnAllPanelsOff()
        currentIndexOfSequence = 0
        status.value = .yourTurn
    }
    
    // ADDS ANOTHER COLOR TO THE SEQUENCE AND SHUFFLES, THEN SAVES TO USER DEFAULTS
    func generateNextSequenceAndStoreToUserDefaults() {
        guard let randomPanelColor = colorOptions.randomElement() else { return }
        sequence.append(randomPanelColor)
        sequence.shuffle()
        
        storeDemoSequenceToUserDefaults()
    }
    
}

// MARK: -  EXTENTION - FLASH NEXT PANEL
extension ViewModel {
    
    // IS TOLD WHICH COLOR NEEDS TO BE TURNED ON OR OFF
    func flashNextColor(_ currentColor: PanelColor) {
        if currentColor == .red {
            redFlashed = true
            greenFlashed = false
            yellowFlashed = false
            blueFlashed = false
        } else if currentColor == .green {
            redFlashed = false
            greenFlashed = true
            yellowFlashed = false
            blueFlashed = false
        } else if currentColor == .yellow {
            redFlashed = false
            greenFlashed = false
            yellowFlashed = true
            blueFlashed = false
        } else if currentColor == .blue {
            redFlashed = false
            greenFlashed = false
            yellowFlashed = false
            blueFlashed = true
        }
    }
}

// MARK: -  EXTENTION - TURN ALL PANELS OFF
extension ViewModel {
    
    // TELLS THE VIEW THE OPACITY OFF ALL PANELS NEEDS TO BE REDUCED
    func turnAllPanelsOff() {
        redFlashed = false
        greenFlashed = false
        yellowFlashed = false
        blueFlashed = false
    }
}

// MARK: - EXTENSION - SOUND AND HAPTICS SETTINGS
extension ViewModel {
    
    // RETRIEVES THE VALUES STORED IN USER DEFAULTS FOR SOUND AND HAPTICS
    // THE USER HAS THE OPTION FOR DEFAULT, LOUR OR SILENT MODE
//    func playSoundsAndHaptics() {
//        let silentModeIsEnabled = UserDefaults.getSilentValue()
//        let loudModeIsEnabled = UserDefaults.getLoudValue()
//        
//        if silentModeIsEnabled {
//            // No sound or haptics
//        } else if loudModeIsEnabled {
//            WKInterfaceDevice.current().play(.start)
//        } else {
//            WKInterfaceDevice.current().play(.click)
//        }
//    }
}

// MARK: - EXTENTION - USER DEFAULTS SET/GET SEQUENCE
extension ViewModel {
    
    // GETS THE LAST CREATED SEQUENCE SO THE USER CAN PLAY THE SAME LEVEL AGAIN
    func getDemoSequenceFromUserDefaults() {
        do {
            if let data = UserDefaults.standard.data(forKey: Constants.dataSequenceKey) {
                let array = try JSONDecoder().decode([PanelColor].self, from: data)
                sequence = array
            }
        } catch {
            print(error)
        }
    }
    
    // NEW SEQUENCE IS STORED TO USER DEFAULTS SO IT CAN BE RETRIEVED AGAIN IF THE USER FAILS
    func storeDemoSequenceToUserDefaults() {
        let data = try! JSONEncoder().encode(sequence)
        UserDefaults.standard.set(data, forKey: Constants.dataSequenceKey)
    }
}

// MARK: -  EXTENTION - GET STORED VALUES FROM USER DEFAULTS
extension UserDefaults {
    
    // GETS USERS CURRENT SCORE
    static func getUserScoreValue() -> Int {
        return UserDefaults.standard.integer(forKey: ViewModel.Constants.userScoreKey)
    }
    
    // GETS USERS HIGH SCORE - NOT CURRENTLY USED
    static func getHighScoreValue() -> Int {
        return UserDefaults.standard.integer(forKey: ViewModel.Constants.highScoreKey)
    }
    
    // GETS THE VALUE FOR SETTINGS - SILENT MODE
    static func getSilentValue() -> Bool {
        return UserDefaults.standard.bool(forKey: ViewModel.Constants.silentKey)
    }
    
    // GETS THE VALUE FOR SETTINGS - LOUD MODE
    static func getLoudValue() -> Bool {
        return UserDefaults.standard.bool(forKey: ViewModel.Constants.loudKey)
    }
}

// MARK: - CHECKS IF A USER HAS CREATED A NEW HIGHSCORE - CURRENTLY NOT SHOWING
extension ViewModel {
    
    // COMPARES THE PREVIOUSLY STORED SCORE WITH THE NEW SCORE
    func hasCreatedNewHighScore(_ currentScore: Int) -> Bool {
        let previousScore = UserDefaults.getHighScoreValue()
        
        if currentScore > previousScore {
            return true
        } else {
            return false
        }
    }
}

// MARK: - CONSTANTS
private extension ViewModel {
    enum Constants {
        // STATUS MESSAGE TEXTS
        static let failedText = "You Lose!"
        static let successText = "Well Done!"
        static let yourTurnText = "Your Turn Now"
        static let resumeText = "Tap to Resume"
        static let tryAgainText = "Tap to Try Again"
        
        // USER DEFAULT KEYS
        static let dataSequenceKey = "dataSequence"
        static let userScoreKey = "userScore"
        static let highScoreKey = "highScore"
        static let silentKey = "silentKey"
        static let loudKey = "loudKey"
    }
}
