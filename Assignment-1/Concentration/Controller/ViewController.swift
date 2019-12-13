//
//  ViewController.swift
//  Concentration
//
//  Created by Volkan Sahin on 10.12.2019.
//  Copyright © 2019 Volkan Sahin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var buttons: [UIButton]!
    
    // Call Game model(Concentration file) with number of card (number of buttons/2)
    lazy var game = Concentration(numberOfCard: (buttons.count + 1) / 2)
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    var emojis = [String]()
    var backgroundColor = UIColor()
    var cardColor = UIColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        // Takes the index of the button pressed
        if let cardNumber = buttons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    func updateViewFromModel(){
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
        for index in buttons.indices{
            let button = buttons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.setTitle(emoji(for : card), for: UIControl.State.normal)
            }else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : cardColor
            }
        }
    }
    
    @IBAction func newGamePressed(_ sender: UIButton) {
        game = game.newGame(with : (buttons.count + 1) / 2)
        updateViewFromModel()
        newGame()
    }
    
    func newGame(){
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
        // TODO: Theme generation
        let themeNames = ["Halloween", "Animals", "Sports", "Faces", "Food", "Vehicles", "Techs"]
        let themeIndex =  Int(arc4random_uniform(UInt32(themeNames.count)))
        let theme = themeNames[themeIndex]
        
        switch theme {
            case "Halloween":
                emojis = ["😈",  "👻", "💀" , "🎃", "🦇", "🍎", "🍭", "🍬", "😱" ]
                backgroundColor = .black
                cardColor = .orange
            case "Animals":
                emojis = ["🐶",  "🐱", "🐼" , "🐨", "🐷", "🐮", "🐸", "🦁", "🐙" ]
                backgroundColor = .lightGray
                cardColor = .yellow
            case "Sports":
                emojis = ["⚽️",  "🏀", "🏈" , "⚾️", "⛳️", "🎾", "🏐", "🏓", "⛸" ]
                backgroundColor = .systemGray5
                cardColor = .blue
            case "Faces":
                emojis = ["😇",  "🤣", "🥰" , "😎", "🤪", "🧐", "😡", "😩", "🥺" ]
                backgroundColor = .yellow
                cardColor = .red
            case "Food":
                emojis = ["🍓",  "🥐", "🥨" , "🥑", "🍔", "🍤", "🍙", "🍕", "🍳" ]
                backgroundColor = .cyan
                cardColor = .brown
            case "Vehicles":
                emojis = ["🚗",  "🛺", "🚎" , "🚁", "🛵", "🚠", "🚜", "✈️", "🚢" ]
                backgroundColor = .yellow
                cardColor = .orange
            case "Techs":
                emojis = ["⌚️",  "💻", "📷" , "📡", "🧬", "📼", "📺", "🕹", "📱" ]
                backgroundColor = .black
                cardColor = .blue
            default:
                emojis = ["😈",  "👻", "💀" , "🎃", "🦇", "🍎", "🍭", "🍬", "😱" ]
                backgroundColor = .black
                cardColor = .orange
        }
        view.backgroundColor = backgroundColor
        for button in buttons{
            button.backgroundColor = cardColor
        }
        newGameButton.backgroundColor = cardColor
        newGameButton.setTitleColor(backgroundColor, for: UIControl.State.normal)
        newGameButton.layer.cornerRadius = newGameButton.frame.height/2
        flipCountLabel.textColor = cardColor
        scoreLabel.textColor = cardColor
    }
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil{
            if emojis.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojis.count)))
                emoji[card.identifier] = emojis.remove(at: randomIndex)
            }
        }
        return emoji[card.identifier] ?? "?"
    }
}

