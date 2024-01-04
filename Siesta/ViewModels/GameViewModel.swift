//
//  GameViewModel.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 22/11/2023.
//

import SwiftUI
import Combine
import StoreKit

struct DailyScoreRecord {
    let id = UUID()
    let date: String
    var score: Int
}

struct PieChartItem {
    let id = UUID()
    let group: Int
    let total: Int
}

final class ViewModel: ObservableObject {
    
    private let hapticsManager = HapticsManager()
    private let reviewManager = ReviewManager()
    let sessionManager = SessionManager()
    
    
    // MARK: - USING COMBINE
    // Using Combine's CurrentValueSubject to pass the state as a value
    var status = CurrentValueSubject<StatusType, Error>(.start)
    
    // Cancellables ensure subsciptions are stored if a view is recreated
    // but can be removed aka cancelled at a later time to release memory
    // Therefore storing them prevents accidental memory leaks
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - USING USERDEFAULTS
    // SwiftUI uses appStorage for User Default similarly to an ObservableObject
    // Any changes to the value are automatically stored and can reload the view
    @AppStorage("userScore") var userScore = 0
    @AppStorage("highScore") var highScore = 0
    
    // The most recent app version that prompts for a review.
    @AppStorage("lastVersionPromptedForReview") var lastVersionPromptedForReview = ""
    
    // MARK: - GAME SEQUENCE FUNCTIONALITY
    private var timer: Timer?
    
    // THE COLORS OPTIONS USED TO CREATE THE RANDOM DEMO SEQUENCE
    private var colorOptions: [PanelColor] = [.red, .green, .yellow, .blue]
    
    // THE DEMO SEQUENCE WHICH WILL BE FLASHED
    private var sequence: [PanelColor] = [.red, .green, .yellow, .blue]
    
    // THE SEQUENCE OF COLORS THAT THE USER HAS SELECTED
    private var userInput: [PanelColor] = []
    
    private var lastScore = 0
    private var dailyScoreRecords: [DailyScoreRecord] = []
    
    var mockDailyScoreRecords: [DailyScoreRecord] = [DailyScoreRecord(date: "04.01.24", score: 2),
                                                     DailyScoreRecord(date: "05.01.24", score: 1),
                                                     DailyScoreRecord(date: "06.01.24", score: 5),
                                                     DailyScoreRecord(date: "07.01.24", score: 2),
                                                     DailyScoreRecord(date: "10.01.24", score: 2),
                                                     DailyScoreRecord(date: "15.01.24", score: 1)]
    
    @Published var pieChartData: [PieChartItem] = []
    
    private var currentIndexOfSequence = 0
    
    
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
    
    private func addSubscriptions() {
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
    private func demoMode() {
        didStartGame = true
        sessionManager.startSession()
        gameDemoSequenceStarted()
    }
    
    // MARK: - YOUR TURN MESSAGE IS SHOWN
    // Tells the user they need to start selecting panels
    // Allows the user to play the game by enabling the panels
    private func yourTurnMessageIsShown() {
        showMessage = true
        statusLabel = Constants.yourTurnText
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
    private func userIsSuccessfull() {
        panelEnabled = false
        turnAllPanelsOff()
        generateNextSequenceAndStoreToUserDefaults()
        
        userInput = []
        userScore += 1
        if hasCreatedNewHighScore(userScore) {
            highScore = userScore
        }
        saveUserScore()
        wellDoneMessageIsShown()
    }
    
    private func saveUserScore() {
        // get todays date as string
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        let today = formatter.string(from: Date.now)
        print(today)
        
        // last score is the highest user score
        if lastScore < userScore {
            lastScore = userScore
        }
        print(lastScore)
        
        // Checks if last record was created today
        // if yes, has the user created a higher score
        // if yes, remove the last record
        // create a new record with the new score
        if dailyScoreRecords.last?.date == today {
            if dailyScoreRecords.last?.score ?? 0 < userScore {
                _ = dailyScoreRecords.popLast()
                let data = DailyScoreRecord(date: today, score: lastScore)
                dailyScoreRecords.append(data)
            }
        } else {
            // if there has been no record created today
            // create a new record with the user score
            let data = DailyScoreRecord(date: today, score: lastScore)
            dailyScoreRecords.append(data)
        }
        print(dailyScoreRecords)
        
        groupUserRecord()
    }
    
    private func groupUserRecord() {
        
        var groups = Dictionary(grouping: mockDailyScoreRecords, by: { $0.score })
        
        
        
//        // replace mock with actual dailyScoreRecords
//        var groups: [String: Int] = [:]
//        var title = ""
//        for record in mockDailyScoreRecords {
//            title = String(record.score)
//            groups[title] = (groups[title] ?? 0) + 1
//        }
//        
//        print(groups)
        /*
        [2: [Siesta.DailyScoreRecord(id: 2F7DCFD1-44C8-4C6B-851C-04BAC72BCA4B, date: "04.01.24", score: 2), Siesta.DailyScoreRecord(id: D161E428-7C18-4F0C-A9E2-12F0A18BCE3F, date: "07.01.24", score: 2), Siesta.DailyScoreRecord(id: 0C810096-75F5-478D-BA9C-53CF65C28120, date: "10.01.24", score: 2)],
         1: [Siesta.DailyScoreRecord(id: 71C38BF5-E4E7-47E9-8BBE-7EEDD8A8DBBA, date: "05.01.24", score: 1), Siesta.DailyScoreRecord(id: D7AB9AC0-416A-4D70-9015-B0F972E49D9D, date: "15.01.24", score: 1)],
         5: [Siesta.DailyScoreRecord(id: 3CEC9EBF-FD7D-448B-AC73-B79BB135BCD8, date: "06.01.24", score: 5)]]
        
        */

        
        
        createPieChartItems(with: groups)
    }
    
    private func createPieChartItems(with group: [Int: [DailyScoreRecord]]) {
        
        
        for item in group {
            let records = item.value
            
            let total = records.count
            
            let data = PieChartItem(group: item.key, total: total)
            
            pieChartData.append(data)
        }
        
        print(pieChartData)
      
        
//        for record in records {
//            let score = record.score
//            total += score
//        }
        
//        -------
//        for (key, value) in data {
//            let item = PieChartItem(group: key, total: value)
//            pieChartData.append(item)
//        }
//        print(pieChartData)
//        
//        var dictionary = Dictionary(grouping: pieChartData, by: { $0.group })
//        print(dictionary)
        
        
        // --------
//        let dogData: [PetData] = [PetData(year: 2000, population: 5),
//                                  PetData(year: 2010, population: 5.3),
//                                  PetData(year: 2015, population: 7.9),
//                                  PetData(year: 2022, population: 10.6)]
//       
//       
//            var catTotal: Double {
//                catData.reduce(0) { $0 + $1.population }
//            }
//
//            var dogTotal: Double {
//                dogData.reduce(0) { $0 + $1.population }
//            }
//
//            var data: [(type: String, amount: Double)] {
//                [(type: "cat", amount: catTotal),
//                 (type: "dog", amount: dogTotal)
//                ]
//            }
//
//            var maxPet: String? {
//                data.max { $0.amount < $1.amount }?.type
//            }

    }
    
    // MARK: - USER FAILED
    // The user selected the wrong panel
    // Their previous activity is cleared and you lost message is shown
    private func userDidFail() {
        panelEnabled = false
        userInput = []
        youLoseMessageIsShown()
    }
    
    // MARK: - WELL DONE MESSAGE IS SHOWN
    // User is shown the well done message
    // After a delay the users new score is shown
    private func wellDoneMessageIsShown() {
        showMessage = true
        statusLabel = Constants.successText
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.status.value = .score
        }
    }
    
    // MARK: - YOU LOSE MESSAGE IS SHOWN
    // User is told they have lost
    // after a delay they are shown the try again message which they can tap
    private func youLoseMessageIsShown() {
        showMessage = true
        statusLabel = Constants.failedText
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.status.value = .again
        }
    }
    
    // MARK: - USER SCORE MESSAGE IS SHOWN
    // User is told their current score as per the value stored in UserDefaults
    // After the message the next demo is started immediately.
    private func userScoreMessageIsShown() {
        showMessage = true
        statusLabel = "Score is: \(userScore)"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showMessage = false
            self.status.value = .demo
        }
    }
    
    // MARK: - TRY AGAIN MESSAGE IS SHOWN
    // If the user has lost they are shown the try again message
    // If tapped a the same demo is played again
    private func tryAgainMessageIsShown() {
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
    private func stoppedGame() {
        sessionManager.stopSession()
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
    private func resumeGame() {
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
        hapticsManager.playSoundsAndVibrations()
        flashNextColor(panelColor)
        userInput.append(panelColor)
        validateUserInput()
    }
    
    // MARK: - INPUT VALIDATION
    // Checks what the user has tapped on against the stored sequence array
    // if correct then checks if the entire sequence has been completed
    // if it has it starts the success journey
    // if the user has tapped incorrectly then the fail journey starts
    private func validateUserInput() {
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
private extension ViewModel {
    
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
        sessionManager.stopSession()
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
private extension ViewModel {
    
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
private extension ViewModel {
    
    // TELLS THE VIEW THE OPACITY OFF ALL PANELS NEEDS TO BE REDUCED
    func turnAllPanelsOff() {
        redFlashed = false
        greenFlashed = false
        yellowFlashed = false
        blueFlashed = false
    }
}


// MARK: - EXTENTION - USER DEFAULTS SET/GET SEQUENCE
private extension ViewModel {
    
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

// MARK: - CHECKS IF A USER HAS CREATED A NEW HIGHSCORE - CURRENTLY NOT SHOWING
private extension ViewModel {
    
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

// MARK: - CHECKS IF A USER HAS SCORED 15+ & IS ON A NEW APPVERSION BEFORE ASKING FOR FEEDBACK
extension ViewModel {
    
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
        let currentScore = UserDefaults.getUserScoreValue()
        guard currentScore > 14 else { return }
        
        // Gets the current app version
        let infoDictionaryKey = kCFBundleVersionKey as String
        guard let currentAppVersion = Bundle.main.object(forInfoDictionaryKey: infoDictionaryKey) as? String
        else { fatalError("Expected to find a bundle version in the info dictionary") }
        
        // Checks the last tiem a review was requested, and if it was for the same version
        // If it's a different version then the review screen is presented
        // The last Version Prompted For Review is updated
        if currentAppVersion != lastVersionPromptedForReview {
            reviewManager.presentReview()
            lastVersionPromptedForReview = currentAppVersion
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
    }
}
