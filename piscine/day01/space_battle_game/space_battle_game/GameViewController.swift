//
//  GameViewController.swift
//  space_battle_game
//
//  Created by Mohammad Butt on 10/12/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let view = self.view as! SKView?
        {
            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameScene")
            let scene = GameScene(size: CGSize(width: 1536, height: 2048))
//            {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
//            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool
    {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            return .allButUpsideDown
        } else
        {
            return .all
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool
    {
        return true
    }
}
