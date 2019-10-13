//
//  GameScene.swift
//  space_battle_game
//
//  Created by Mohammad Butt on 10/12/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    let player = SKSpriteNode(imageNamed: "playership01")
    
    let bulletSound = SKAction.playSoundFileNamed("bulletSoundEffect01.wav", waitForCompletion: false)
    

/*
     Below function will generate a random number between min and max range.
     In a nutshell random number that is generated by doing the modulo with the difference of min and max.
     1 is added to the difference when modulous is performed to offset the 1.
     Finally, min value is added to get the random number to be between min and max.
     
     If 1 is not added then, max number will never be generated.
     Few more steps were performed to type cast the random number into an int so modulo with the difference
     can be achieved because arc4random is an unsigned integer and we cannot modulo an unsigned int with an
     int in swift, but it can be done in C.
*/
/*
    func random(min: Int, max: Int) -> Int
    {
        var difference: Int = 0
        var newRandomNumber: Int = 0
        var castedRandomNumber: Int = 0
        
        difference = max - min
        difference = difference + 1
        castedRandomNumber = Int(arc4random()/2)
     
        newRandomNumber = castedRandomNumber % difference
        newRandomNumber = newRandomNumber + min
        return newRandomNumber
    }
 */
    func random(min: CGFloat, max: CGFloat) -> CGFloat
    {
        var difference: Int = 0
        var newRandomNumber: Int = 0
        var newRandomNumberFloat: CGFloat = 0
        var castedRandomNumber: Int = 0
        
        difference = (Int)(max - min)
        difference = difference + 1
        castedRandomNumber = Int(arc4random() / 2)
        
        newRandomNumber = castedRandomNumber % difference
        newRandomNumberFloat = CGFloat (newRandomNumber) + min
    
        return newRandomNumberFloat
    }
// CGRect is a struct that contains the dimensions and location of the rectangle
    var gameArea = CGRect()
    
    override init(size: CGSize)
    {
        let maxAspectratio: CGFloat = 16.0/9.0
        let playableWidth = size.height/maxAspectratio
        let margin = (size.width - playableWidth) / 2
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView)
    {
        let background = SKSpriteNode(imageNamed: "background06")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        player.setScale(0.2)
        player.position = CGPoint(x: self.size.width/2, y: self.size.height/5)
        player.zPosition = 2
        self.addChild(player)
    }
/*
    func fireBullet()
    {
        let bullet = SKSpriteNode(imageNamed: "bullet01")
        bullet.setScale(0.03)
        bullet.zRotation = CGFloat((90 * (Double.pi/180))) // or  1.57
        bullet.position = player.position
        player.zPosition = 1
        self.addChild(bullet)
        
        let moveBullet = SKAction.moveTo(y: self.size.height + bullet.size.height, duration: 1)
        let deleteBullet = SKAction.removeFromParent()
        let bulletSequence = SKAction.sequence([moveBullet, deleteBullet])
        bullet.run(bulletSequence)
    }
*/

    func fireBullet()
    {
        let bullet = SKSpriteNode(imageNamed: "bullet13")
        bullet.setScale(1)
        bullet.position = player.position
        player.zPosition = 1
        self.addChild(bullet)
        
        let moveBullet = SKAction.moveTo(y: self.size.height + bullet.size.height, duration: 1)
        let deleteBullet = SKAction.removeFromParent()
        let bulletSequence = SKAction.sequence([bulletSound, moveBullet, deleteBullet])
        bullet.run(bulletSequence)
    }
    
    func spawnEnemy()
    {
        let randomXStart = random(min: (gameArea.maxX), max: (gameArea.minX))
        let randomXEnd = random(min: gameArea.maxX, max: (gameArea.minX))
        
        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
        let enemy = SKSpriteNode(imageNamed: "enemyship01")
        enemy.setScale(0.2)
        enemy.position = startPoint
        enemy.zPosition = 2
        self.addChild(enemy)
        
        let moveEnemy = SKAction.move(to: endPoint, duration: 1.5)
        let deleteEnemy = SKAction.removeFromParent()
        let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy])
        enemy.run(enemySequence)
        
        
    }

// Whenever screen is pressed touchesbegan function is called to perform a function, in this
// case to fire bullets.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        fireBullet()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            
            player.position.x += amountDragged
            if (player.position.x > gameArea.maxX - player.size.width)
            {
                player.position.x = gameArea.maxX - player.size.width
            }
            if (player.position.x < gameArea.minX + player.size.width)
            {
                player.position.x = gameArea.minX + player.size.width
            }
            
            
        }
    }
}

/*
class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
*/
