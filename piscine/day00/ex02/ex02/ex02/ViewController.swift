//
//  ViewController.swift
//  ex02
//
//  Created by Mohammad Butt on 10/8/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//

/*
Ex02 - Join the OO Party

 This assignment is to teach us the basics of Object Oriented Programming, or OOP/OO for short.
 
 We are delving into some of the more interesting features of UIKit, dealing with layers, shaders and
 particles. Not only is this neat to know, but it’s also a great chance to cut our teeth on how objects and
 inheritance works (which is foundational of what Object Oriented Programming is).
 
 Use the project built previously, but now instead of pushing an update notification we are going to spray
 confetti all over the screen. You can make the confetti look however you want (snow, puppies, confetti, etc)
 but there must be 3 separate images, of varying sizes, and varying velocity. One button will create confetti,
 one button will stop it.
 
 Congratulations, you now know how to use basic animations, use layers, particle systems and the core ideas
 of object oriented programming. This is worth celebrating.
*/

import UIKit


class ViewController: UIViewController
{

    @IBOutlet weak var ftUILabel: UILabel!
    
    var emitter1 = Emitter.get(with: #imageLiteral(resourceName: "spark"))
    var emitter2 = Emitter.get(with: #imageLiteral(resourceName: "fireSpark1"))
    var emitter3 = Emitter.get(with: #imageLiteral(resourceName: "fireSpark2"))
    func snowDribbleBalls()
    {
        emitter1.emitterPosition = CGPoint(x: view.frame.width / 2, y: 0)
        emitter2.emitterPosition = CGPoint(x: view.frame.width / 3, y: 5)
        emitter3.emitterPosition = CGPoint(x: view.frame.width / 4, y: 6)
        emitter1.emitterSize = CGSize(width: view.frame.width, height: 2)
        emitter2.emitterSize = CGSize(width: view.frame.width, height: 4)
        emitter3.emitterSize = CGSize(width: view.frame.width, height: 6)
        
        emitter1.name = "EmitterForRemove"
        emitter2.name = "EmitterForRemove"
        emitter3.name = "EmitterForRemove"
        
        view.layer.addSublayer(emitter1)
        view.layer.addSublayer(emitter2)
        view.layer.addSublayer(emitter3)
    }
    
    func showAlert(headerTitle: String, bodyMessage: String, dismiss: String)
    {
        let alert = UIAlertController(title: headerTitle, message: bodyMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: dismiss, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func ftUIButton1(_ sender: UIButton)
    {
        let ftFontName = "Chalkduster"
        let ftMessage = "Font changed to " + ftFontName + " 20.0"
        ftUILabel.font = UIFont.systemFont(ofSize: 20.0)
        ftUILabel.font = UIFont(name: ftFontName, size: 20.0)
        showAlert(headerTitle: "Notification", bodyMessage: ftMessage, dismiss: "Ok")
        snowDribbleBalls()
    }
    
    @IBAction func ftUIButton2(_ sender: UIButton)
    {

        emitter1.lifetime = 0
        emitter2.lifetime = 0
        emitter3.lifetime = 0
        
        let delayInSeconds = 7.0
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + delayInSeconds)
        {
            for snowDribbleBalls in self.view.layer.sublayers!
            {
                if snowDribbleBalls.name == "EmitterForRemove"
                {
                    snowDribbleBalls.removeFromSuperlayer()
                }
            }
        }

        let ftFontName = "Arial"
        let ftMessage = "Font changed to \(ftFontName) 25.0"
        ftUILabel.font = UIFont.systemFont(ofSize: 25.0)
        ftUILabel.font = UIFont(name: ftFontName, size: 25.0)
        showAlert(headerTitle: "Notification", bodyMessage: ftMessage, dismiss: "ok")
      
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

