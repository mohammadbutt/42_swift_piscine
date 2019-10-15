//
//  ViewController.swift
//  ex00Stopwatch
//
//  Created by Mohammad Butt on 10/15/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//
// Exercise 00: Stopwatch
//
// We are creating what we call a countup timer one that has numeric display, a pause button, a start button
// and a reset button. When the start button is clicked it should start counting the seconds, minutes and
// hours as time goes on and visually display these numbers. The pause button should stop the counting, and
// continue it when pressed again. Reset should set the clock value back to zero.
//
// Hint: Use Swift’s Timer Class
//
// reference: www.youtube.com/watch?v=BKyswk18joM

import UIKit

class ViewController: UIViewController
{
    var timer = Timer()
    
    var (hours, minutes, seconds, fractions) = (0, 0, 0, 0)
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func startButton(_ sender: UIButton)
    {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.keepTimer), userInfo: nil, repeats: true)
    }
    @IBAction func pauseButton(_ sender: UIButton)
    {
        /*
        If timer is initialized as below:
            weak var timer = Timer()
        then time is invalidated with a question mark, as shown below:
            timer?.invalidate()
        */
        timer.invalidate()
    }
    @IBAction func resetButton(_ sender: UIButton)
    {
        timer.invalidate()
        (hours, minutes, seconds, fractions) = (0, 0, 0, 0)
        timeLabel.text = "00:00:00.00"
    }
    
    @objc func keepTimer()
    {
        fractions += 1
        if(fractions > 99)
        {
            seconds += 1
            fractions = 0
        }
        
        if(seconds == 60)
        {
            minutes += 1
            seconds = 0
        }
        if(minutes == 60)
        {
            hours += 1
            minutes = 0
        }
        timeLabel.text = String(format: "%02d:%02d:%02d.%02d", hours, minutes, seconds, fractions)
    }
    
/*
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
*/

}

