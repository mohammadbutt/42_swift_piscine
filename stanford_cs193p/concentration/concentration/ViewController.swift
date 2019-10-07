//
//  ViewController.swift
//  concentration
//
//  Created by Mohammad Butt on 10/5/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//

import UIKit

/*
func flipCard(withEmoji emoji: String, on button: UIButton)
{
    if button.currentTitle == emoji
    {
        button.setTitle("0", for: UIControlState.normal)
        button.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    }
    else
    {
        button.setTitle(emoji, for: UIControlState.normal)
        button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}
*/
class ViewController: UIViewController
{
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    var flipCount: int_fast32_t = 0
    {
        didSet
        {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["🎃","👻","🎃","👻", "🌈", "😈", "🍊", "🍎"]
    var emoji = [Int:String]()
    
    
    
    @IBAction func touchCard(_ sender: UIButton)
    {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender)
        {
//            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
              game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else
        {
            print("Bad character");
        }
    }
    func updateViewFromModel()
    {
        for index in cardButtons.indices
        {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp
            {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else
            {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.5667926669, green: 0.4311806262, blue: 0.01843718253, alpha: 0.4995323504)  : #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            }
        }
    }

    func emoji(for card: Card) -> String
    {
        if emoji[card.identifier] == nil
        {
            if emojiChoices.count > 0
            {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
        }
        return emoji[card.identifier] ?? "?"
    }
}







