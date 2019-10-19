//
//  ViewController.swift
//  ex01UIGestures
//
//  Created by Mohammad Butt on 10/18/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//
// References:
// www.youtube.com/watch?v=gAU3VE7T21M
// stackoverflow.com/questions/42288167/how-to-change-the-background-color-of-a-uilabel-with-swift
//
// Ex01: UI Gestures
// We are learning how to implement UI Gestures. Many are built in classes in swift but we need to learn how to use them.
// We will have the background change color when we do different gestures.
// Tap = Pink, Pinch = Green, Swipe Up = Yellow, Swipe Down = Red, Swipe Right Blue, Swipe Left = Purple, Rotation = Peach.

import UIKit

class ViewController: UIViewController
{

    // Connect "Image View" from the storyboard to swipe Gesture
    // Connect swipe gesture to the ViewController.swift
    
    @IBOutlet weak var uiLabel: UILabel!
    
    @IBAction func swipRight(_ sender: UISwipeGestureRecognizer)
    {
        uiLabel.backgroundColor = UIColor.blue
    }
    
    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer)
    {
        uiLabel.backgroundColor = UIColor.red
    }
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer)
    {
        uiLabel.backgroundColor = UIColor.purple
    }
    
    @IBAction func swipeUp(_ sender: UISwipeGestureRecognizer)
    {
        uiLabel.backgroundColor = UIColor.yellow
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer)
    {
        uiLabel.backgroundColor = UIColor.magenta
    }
    
    @IBAction func pinch(_ sender: UIPinchGestureRecognizer)
    {
        //Press and hold pption/alt to get into pinch mode
        uiLabel.backgroundColor = UIColor.green
    }
    
    
    @IBAction func rotation(_ sender: UIRotationGestureRecognizer)
    {
        // There is no peach color, so using orange instead
        // Press and hold option/alt button on keyboard to get into rotation mode
        uiLabel.backgroundColor = UIColor.orange
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

