//
//  ViewController.swift
//  ex01PomodoroTimer
//
//  Created by Mohammad Butt on 10/15/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//
// Exercise 01: Pomodoro Timer
//
// Similar to the last assignment but now we are creating a countdown timer. It should have a numeric display,
// a pause button, a start button and a reset button. When the start button is clicked it should start
// counting down from 25 min and visually display these numbers down to the second. The pause button should
// stop the counting, and continue it when pressed again. Reset should set the clock value back to 25 min.
//
// Hint: Use Swift’s Timer Class
//

import UIKit

class ViewController: UIViewController
{
    
    var timer = Timer()
    
    var (minutes, seconds, fractions) = (25, 0, 0)
    
    @IBOutlet weak var minutesLabel: UILabel!
    
    @IBOutlet weak var secondsLabel: UILabel!
    
    @IBAction func minutesStepper(_ sender: UIStepper)
    {
        minutes = Int(sender.value)
        minutesLabel.text = String(format: "%02d", minutes)
    }
    
    @IBAction func secondsStepper(_ sender: UIStepper)
    {
        seconds = Int(sender.value)
        secondsLabel.text = String(format: "%02d", seconds)
    }
    @IBAction func startButton(_ sender: UIButton)
    {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.keepTimer), userInfo: nil, repeats: true)
    }
    
    @IBAction func pauseButton(_ sender: UIButton)
    {
        timer.invalidate()
    }
    @IBAction func resetButton(_ sender: UIButton)
    {
        timer.invalidate()
        (minutes, seconds, fractions) = (25, 0, 0)
        minutesLabel.text = "25"
        secondsLabel.text = "00"
    }
    
    @objc func keepTimer()
    {
        fractions -= 1
        if(fractions < 0)
        {
            seconds -= 1
            fractions = 99
        }
        if(seconds == -1)
        {
            minutes -= 1
            seconds = 59
        }
        if(minutes == 0 && seconds == 0 && fractions <= 0)
        {
            timer.invalidate()
        }
        minutesLabel.text = String(format: "%02d", minutes)
        secondsLabel.text = String(format: "%02d", seconds)
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





