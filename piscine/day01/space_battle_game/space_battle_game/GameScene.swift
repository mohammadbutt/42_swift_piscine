//
//  GameScene.swift
//  space_battle_game
//
//  Created by Mohammad Butt on 10/12/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
// Reference: www.youtube.com/watch?v=mvlwZs2ehLU&list=WL&index=2&t=9s series
// Resources: ezgif.com/sprite-cutter - to split/cut up laser sprites
//

import SpriteKit
import GameplayKit
import UIKit
import ImageIO

var gameScore = 0

class GameScene: SKScene, SKPhysicsContactDelegate
{
    let scoreLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    var livesNumber = 3
    let livesLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    var levelNumber = 0
    let levelLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    let player = SKSpriteNode(imageNamed: "playership01")
    
    let bulletSound = SKAction.playSoundFileNamed("bulletSoundEffect01.wav", waitForCompletion: false)
    let enemyExplosion = SKAction.playSoundFileNamed("enemyBoom01.flac", waitForCompletion: false)
    let playerExplosion = SKAction.playSoundFileNamed("playerBoom01.wav", waitForCompletion: false)
    
    enum gameState
    {
        case preGame   // Game state before the start of the game
        case inGame    // Game state during the game
        case afterGame // Game state after the game
    }
    
    var currentGameState = gameState.inGame
    
    struct PhysicsCategories
    {
        static let None: UInt32 =  0 //0
        static let Player: UInt32 = 1 //0b1   //1
        static let Bullet: UInt32 = 2 //0b10  //2
        static let Enemy: UInt32 =  4 //0b100 //4
    }

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

    func randomInteger(min: Int, max: Int) -> Int
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
 
    func random(min: CGFloat, max: CGFloat) -> CGFloat
    {
        var difference: Int = 0
        var randomNumber: Int = 0
        var randomNumberFloat: CGFloat = 0
        var castedRandomNumber: Int = 0
        
        difference = (Int)(max - min)
        difference = difference + 1
        castedRandomNumber = Int(arc4random() / 2)
        
        randomNumber = castedRandomNumber % difference
        randomNumberFloat = CGFloat (randomNumber) + min
        
        return randomNumberFloat
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
        gameScore = 0 // Score is set to 0, so everytime the game starts the score can start at 0
        self.physicsWorld.contactDelegate = self
        
        let background = SKSpriteNode(imageNamed: "background06")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        player.setScale(0.2)
        player.position = CGPoint(x: self.size.width/2, y: self.size.height/5)
        player.zPosition = 2
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody!.affectedByGravity = false
        player.physicsBody!.categoryBitMask = PhysicsCategories.Player
        player.physicsBody!.collisionBitMask = PhysicsCategories.None
        player.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
        self.addChild(player)
        
        scoreLabel.text = "Score: 0"
        scoreLabel.fontSize = 50 // 70
        scoreLabel.fontColor = SKColor.white
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.position = CGPoint(x: self.size.width*0.22, y: self.size.height*0.9)
        scoreLabel.zPosition = 100
        self.addChild(scoreLabel)
        
        livesLabel.text = "Lives: 3"
        livesLabel.fontSize = 50 // 70
        livesLabel.fontColor = SKColor.white
        livesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        livesLabel.position = CGPoint(x: self.size.width*0.78, y: self.size.height*0.9)
        livesLabel.zPosition = 100
        self.addChild(livesLabel)
        
        levelLabel.text = "Level: 0"
        levelLabel.fontSize = 50
        levelLabel.fontColor = SKColor.white
        levelLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        levelLabel.position = CGPoint(x: self.size.width*0.58, y: self.size.height*0.9)
        levelLabel.zPosition = 100
        self.addChild(levelLabel)
        
        
        startNewLevel()
    }
    
    func loseALife()
    {
        livesNumber -= 1
        livesLabel.text = "Lives: \(livesNumber)"
        
        let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
        let scaleDown = SKAction.scale(to: 1, duration: 0.2)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        livesLabel.run(scaleSequence)
        
        if livesNumber == 0
        {
            runGameOver()
        }
    }
    
    func addScore()
    {
        gameScore += 1
        scoreLabel.text = "Score: \(gameScore)"
        
        if gameScore == 10 || gameScore == 15 || gameScore == 20
        {
            startNewLevel()
        }
    }
    
    func runGameOver()
    {
        currentGameState = gameState.afterGame
        
        self.removeAllActions()
        
        self.enumerateChildNodes(withName: "Bullet")
        {
            bullet, stop in
            bullet.removeAllActions()
        }
        
        self.enumerateChildNodes(withName: "Enemy")
        {
            enemy, stop in
            enemy.removeAllActions()
        }
        
        let changeSceneAction = SKAction.run(changeScene)
        let waitToChangeScene = SKAction.wait(forDuration: 1)
        let changeSceneSequence = SKAction.sequence([waitToChangeScene, changeSceneAction])
        self.run(changeSceneSequence)
        
    }
    
    func changeScene()
    {
        let sceneToMoveTo = GameOverScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
        {
            body1 = contact.bodyA
            body2 = contact.bodyB
        }
        else
        {
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        
        // If the player hits the enemy
        if (body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Enemy)
        {
            // If there is an object only then will an explosion be caused
//            if (body1.node != nil) // May not be necessary
 //           {
                spawnExplosionPlayer(spawnPosition: body1.node!.position)
  //          }
//            if (body2.node != nil)
//            {
                spawnExplosionPlayer(spawnPosition: body2.node!.position)
//            }
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            runGameOver()
        }
        
        // If the bullet hits the enemy
        if(body1.categoryBitMask == PhysicsCategories.Bullet && body2.categoryBitMask == PhysicsCategories.Enemy)
        {
            if((body2.node?.position.y)! < self.size.height) // Might be able to remove this
            {
  //              if(body2.node != nil)
    //            {
                    spawnExplosion(spawnPosition: body2.node!.position)
  //              }
                addScore()
                body1.node?.removeFromParent()
                body2.node?.removeFromParent()
            }
        }
    }
//

    func spawnExplosion(spawnPosition: CGPoint)
    {
        let explosion = SKSpriteNode(imageNamed: "explosion04")
        explosion.position = spawnPosition
        explosion.zPosition = 3
        explosion.setScale(0)
        self.addChild(explosion)
        
        let scaleIn = SKAction.scale(to: 1, duration: 0.1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        
        let explosionSequence = SKAction.sequence([enemyExplosion, scaleIn, fadeOut, delete])
        
        explosion.run(explosionSequence)
    }
    
    func spawnExplosionPlayer(spawnPosition: CGPoint)
    {
        let explosion = SKSpriteNode(imageNamed: "explosion01")
        explosion.position = spawnPosition
        explosion.zPosition = 3
        explosion.setScale(5)
        self.addChild(explosion)
        
        let scaleIn = SKAction.scale(to: 1, duration: 0.1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        
        let explosionSequence = SKAction.sequence([playerExplosion, scaleIn, fadeOut, delete])
        
        explosion.run(explosionSequence)
    }
    
    func startNewLevel()
    {
        levelNumber += 1
        
        if self.action(forKey: "spawningEnemies") != nil
        {
            self.removeAction(forKey: "spawningEnemies")
        }
        
        var levelDuration = NSTimeIntervalSince1970
        
        switch levelNumber
        {
        case 1: levelDuration = 1.5
        case 2: levelDuration = 1.0
        case 3: levelDuration = 0.5
        case 4: levelDuration = 0.1
        default:
            levelDuration = 0.1
            print("Cannot find levelNumber info")
        }
        
        let spawn = SKAction.run(spawnEnemy)
        let waitToSpaw = SKAction.wait(forDuration: levelDuration)
        let spawnSequence = SKAction.sequence([waitToSpaw, spawn])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        
        levelLabel.text = "Level: \(levelNumber)"
        self.run(spawnForever, withKey: "spawningEnemies")
    }

    func fireBullet()
    {
        let bullet = SKSpriteNode(imageNamed: "bullet18")
        
        bullet.name = "Bullet" // bullet now has a reference name of "Bullet"
        
        bullet.setScale(3)
        bullet.zRotation = CGFloat((90 * (Double.pi/180))) // or  1.57
        bullet.position = player.position
        bullet.zPosition = 1
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        bullet.physicsBody!.affectedByGravity = false
        bullet.physicsBody!.categoryBitMask = PhysicsCategories.Bullet
        bullet.physicsBody!.collisionBitMask = PhysicsCategories.None
        bullet.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
        self.addChild(bullet)
        
        let moveBullet = SKAction.moveTo(y: self.size.height + bullet.size.height, duration: 1)
        let deleteBullet = SKAction.removeFromParent()
        
        let bulletSequence = SKAction.sequence([bulletSound, moveBullet, deleteBullet])
        bullet.run(bulletSequence)
    }

    func spawnEnemy()
    {
        let randomXStart = random(min: gameArea.minX, max: gameArea.maxX)
        let randomXEnd = random(min: gameArea.minX, max: gameArea.maxX)
        
        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
        let enemy = SKSpriteNode(imageNamed: "enemyship01")
        
        enemy.name = "Enemy"
        
        enemy.setScale(0.15)
        enemy.position = startPoint
        enemy.zPosition = 2
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.categoryBitMask = PhysicsCategories.Enemy
        enemy.physicsBody!.collisionBitMask = PhysicsCategories.None
        enemy.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Bullet
        self.addChild(enemy)
        
        let moveEnemy = SKAction.move(to: endPoint, duration: 1.5)
        let deleteEnemy = SKAction.removeFromParent()
        let loseALifeAction = SKAction.run(loseALife)
        let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy, loseALifeAction])
//        let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy])
        
        if (currentGameState == gameState.inGame)
        {
            enemy.run(enemySequence)
        }
        let deltaX = endPoint.x - startPoint.x
        let deltaY = endPoint.y - startPoint.y
        let amountToRotate = atan2(deltaY, deltaX)
        enemy.zRotation = amountToRotate
        
    }

// Whenever screen is pressed touchesbegan function is called to perform a function, in this
// case to fire bullets.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if(currentGameState == gameState.inGame)
        {
            fireBullet()
        }
//        spawnEnemy()
//        print("RandomInter: %d", randomInteger(min: 10, max: 15))
//        print("Randomfloat:%f", random(min: 10, max: 15))
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            
            if(currentGameState == gameState.inGame)
            {
                player.position.x += amountDragged
            }
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
