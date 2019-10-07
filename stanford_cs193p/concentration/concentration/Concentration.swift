//
//  Concentration.swift
//  concentration
//
//  Created by Mohammad Butt on 10/6/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    func chooseCard(at index: Int)
    {
        if cards[index].isFaceUp
        {
            cards[index].isFaceUp = false
        }
        else
        {
            cards[index].isFaceUp = true
        }
    }
    
    init(numberOfPairsOfCards: Int)
    {
        for _ in 1...numberOfPairsOfCards
        {
            let card = Card()
            cards += [card, card]
        }
    }
}
