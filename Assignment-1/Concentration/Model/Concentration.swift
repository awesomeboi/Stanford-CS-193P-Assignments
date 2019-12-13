//
//  Concentration.swift
//  Concentration
//
//  Created by Volkan Sahin on 10.12.2019.
//  Copyright © 2019 Volkan Sahin. All rights reserved.
//

import Foundation

class Concentration{
    var cards = [Card]()
    var flipCount = 0
    var indexOfOneandOnlyFaceUpCard: Int?
    var score = 0
    //Flip chosen card to opposite
    func chooseCard(at index: Int){
        if !cards[index].isMatched{
            flipCount += 1
            if let matchIndex = indexOfOneandOnlyFaceUpCard, matchIndex != index{
                //if cards matched
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 1
                }
                //if cards not matched
                cards[index].isFaceUp = true
                indexOfOneandOnlyFaceUpCard = nil
                //Penalty Control
                if cards[matchIndex].isMatched != true{
                    //check if the first selected card's duplicate seen before
                    var tempArray = [Int]()
                    for i in 0..<cards.count{
                        if cards[i].identifier == cards[matchIndex].identifier{
                            tempArray.append(i)
                        }
                    }
                    tempArray.remove(at: tempArray.firstIndex(of: matchIndex)!)
                    // if the first selected card's duplicate seen before and not opened in the second selection penalty occurs.
                    if cards[tempArray[0]].isPenalty == true{
                        score -= 1
                    }
                    // if secondly opened card have seen before penalty occurs
                    if cards[index].isPenalty == true{
                        score -= 1
                    }
                }
                cards[index].isPenalty = true
            }else{
                // one card open
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneandOnlyFaceUpCard = index
                cards[index].isPenalty = true
            }
        }
    }
    
    //Create cards according to the number of card parameters
    init(numberOfCard:Int){
        for _ in 0..<numberOfCard{
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
        cards.shuffle()
    }
    func newGame(with numberOfButton : Int) -> Concentration{
        let newGame = Concentration.init(numberOfCard: numberOfButton)
        return newGame
    }
}
