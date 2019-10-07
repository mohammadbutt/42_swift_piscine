//
//  ViewController.swift
//  ex01
//
//  Created by Mohammad Butt on 10/6/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//

/*
 Ex 01:
 
 Now it’s not enough to have just one button, we need two. Also Apps should work
 in both landscape and portrait mode. Lucky for us swift/Xcode has tools
 like autolayout to help us.
 
 Our app should have as follows:
 1.Two buttons side by side that adapt to the rotation of the screen and change
 size relationally to the other elements of the page.
 
 2.A UILabel with text describing how awesome you are inside of it, that changes
 between two fonts depending on which button was pressed.
 
 3.A popup notification that alerts us to when a font was changed.
 
 Pro Tip: Look up StackView, and see if you want to use it with autolayout.
*/

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

