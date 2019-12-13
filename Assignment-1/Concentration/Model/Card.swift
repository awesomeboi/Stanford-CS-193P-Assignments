//
//  Card.swift
//  Concentration
//
//  Created by Volkan Sahin on 10.12.2019.
//  Copyright © 2019 Volkan Sahin. All rights reserved.
//

import Foundation

struct Card{
    var isFaceUp = false
    var isMatched = false
    var isPenalty = false
    var identifier: Int
static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
