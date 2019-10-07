//
//  ViewController.swift
//  ex00
//
//  Created by Mohammad Butt on 10/6/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//

/*
 Exercise: You are Awesome("Hello World")
 
 For this first exercise we are learning to create a project, how to display text
 to the screen and how to make a button functional. The trick of this assignment
 is learning how to navigate Xcode.
 
 Create a UIButton, in the main view, that when clicked will display a message in
 Xcode’s debug console and in a UILabel.
*/

import UIKit

/*
func
{
    
}
*/


class ViewController: UIViewController
{
    let message = "Hello World!"
    @IBOutlet weak var ftUILabel: UILabel!
    @IBAction func ftPressButton(_ sender: Any)
    {
        ftUILabel.text = message
        print("\(message)")
    }
    
    override func viewDidLoad()
    {
      super.viewDidLoad()
    }
}

