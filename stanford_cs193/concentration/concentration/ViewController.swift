//
//  ViewController.swift
//  concentration
//
//  Created by Mohammad Butt on 10/5/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//

import UIKit

func flipCard(withEmoji emoji: String, on button: UIButton)
{
    if button.currentTitle == emoji
    {
        button.setTitle("", for: UIControlState.normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    }
    else
    {
        button.setTitle(emoji, for: UIControlState.normal)
        button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    }
}

class ViewController: UIViewController
{
    var flipCount: int_fast32_t = 0
    {
        didSet
        {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
        
    }
    
    var emojiChoices = ["🎃","👻","🎃","👻"]
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton)
    {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender)
        {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            print("cardNumber = \(cardNumber)")

        }
        else
        {
            print("chosen card was not in cardButtons")
        }
    }


}

