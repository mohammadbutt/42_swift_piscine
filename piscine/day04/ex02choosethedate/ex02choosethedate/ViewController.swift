//
//  ViewController.swift
//  ex02choosethedate
//
//  Created by Mohammad Butt on 10/18/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//
// Ex 02 - Choose the date
// For this assignment we are creating a date picker that uses touch gestures and spins.
// Each element should spin separately from the other (I.e. month, year, day).
// It should look something similar to the image below.
// Hint: Use an outlet

import UIKit

class ViewController: UIViewController
{
    // 0. Drop "View" into the story board.
    // 1. Drop 2 "Date Picker" into the story board, inside "View".
    // 2. Click on "Show the Attributes Inspector". Change one to date.
    // 3. Click on second date picker, align it next to the first one and do step 2.
    
    // To make it work horizontally and verically
    //         1. click on view and then click on "Align"
    //         2. click on "Add New Constraints"
    // Done properly, this should make the app work in both orientations.
    
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

