//
//  GameOverScene.swift
//  space_battle_game
//
//  Created by Mohammad Butt on 10/14/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene
{
    let restartLabel = SKLabelNode(fontNamed: "The Bold Font")

    override func didMove(to view: SKView)
    {
        let background = SKSpriteNode(imageNamed: "background17")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let gameOverLabel = SKLabelNode(fontNamed: "The Bold Font")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 175
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.7)
        gameOverLabel.zPosition = 1
        self.addChild(gameOverLabel)
        
        let scoreLabel = SKLabelNode(fontNamed: "The Bold Font")
        scoreLabel.text = "Score: \(gameScore)"
        scoreLabel.fontSize = 125
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.55)
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        
        // UserDefaults gets acess to user's information for game high score. After the game is deleted, high
        // score will be wiped out
        let defaults = UserDefaults()
        var highScoreNumber = defaults.integer(forKey: "highScoreSaved")
        
        // High Score is updated
        if(gameScore > highScoreNumber)
        {
            highScoreNumber = gameScore
            defaults.setValue(highScoreNumber, forKey: "highScoreSaved")
        }
        let highScoreLabel = SKLabelNode(fontNamed: "The Bold Font")
        highScoreLabel.text = "High Score: \(highScoreNumber)"
        highScoreLabel.fontSize = 125
        highScoreLabel.fontColor = SKColor.white
        highScoreLabel.zPosition = 1
        highScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.45)
        self.addChild(highScoreLabel)
        
        restartLabel.text = "Restart"
        restartLabel.fontSize = 90
        restartLabel.fontColor = SKColor.white
        restartLabel.zPosition = 1
        restartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.3)
        self.addChild(restartLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: self)
            if (restartLabel.contains(pointOfTouch))
            {
                let scenceToMoveTo = GameScene(size: self.size)
                scenceToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(scenceToMoveTo, transition: myTransition)
            }
        }
    }
}
