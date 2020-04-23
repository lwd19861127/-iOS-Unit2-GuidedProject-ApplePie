//
//  ViewController.swift
//  Apple Pie
//
//  Created by WendaLi on 2020-04-23.
//  Copyright © 2020 WendaLi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var listOfWords = ["Apple", "Banana", "Cherry", "Durian", "Grape", "Fig", "Lemon", "Lichee", "Mango", "Orange", "Peach", "Pear", "Pitaya", "Pomegranate", "Pomelo", "Strawberry", "Watermelon"]
    var isListOfWordsCountZero = false {
        didSet {
           listOfWords = ["Apple", "Banana", "Cherry", "Durian", "Grape", "Fig", "Lemon", "Lichee", "Mango", "Orange", "Peach", "Pear", "Pitaya", "Pomegranate", "Pomelo", "Strawberry", "Watermelon"]
        }
    }
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    var currentGame: Game!

    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newRound()
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateUI()
        updateGameState()
    }
    
    func newRound() {
        if !listOfWords.isEmpty {
            let randomInt = Int.random(in: 0..<listOfWords.count)
            let newWord = listOfWords[randomInt].lowercased()
            listOfWords.remove(at: randomInt)
            if listOfWords.count == 0 {
                isListOfWordsCountZero = true
            }
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        }else {
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
      for button in letterButtons {
        button.isEnabled = enable
      }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        letters[0] = letters[0].capitalized
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins),  Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }

}

