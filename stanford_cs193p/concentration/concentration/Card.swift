//
//  Card.swift
//  concentration
//
//  Created by Mohammad Butt on 10/6/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifer() -> Int
    {
        identifierFactory += 1
        return identifierFactory
    }
    
    init()
    {
        self.identifier = Card.getUniqueIdentifer()
        
    }
}
