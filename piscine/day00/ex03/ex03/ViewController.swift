//
//  ViewController.swift
//  ex03
//
//  Created by Mohammad Butt on 10/9/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//
// reference: www.youtube.com/watch?v=JuqQUP0pnZY
// reference: stackoverflow.com/questions/44346811/extracting-hours-and-minutes-from-uidatepicker

/*
 Exercise 03: Dates & Times
 Allowed functions: Swift Standard Library, UIKit
 
 We are going to script an event to occur at a specific time, like a minimal alarm clock. A push notification
 will suffice.
*/

import UIKit
import UserNotifications
import Darwin

class ViewController: UIViewController
{
    @IBOutlet weak var ftDatePicker: UIDatePicker!
    
    @IBOutlet weak var ftCountDownLabel: UILabel!
 
    weak var timer = Timer() // time is declared here so time can be invalidated from any function

    @IBAction func ftStartButton(_ sender: UIButton)
    {
//      print("Hello")
        reminderApp()
        runFtCountdown()
    }

    func reminderApp()
    {
// 1: Ask the user for permission. Assume permission is already given in this case
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound])
        {
            (granted, error) in
        }
        
// 2: Notification title and body message
        let content = UNMutableNotificationContent()
        content.title = "Notification"
        content.body = "Friendly reminder"
        
// 3: Create the notification trigger
        var ftDateComponent = DateComponents()
        let ftDate = ftDatePicker.date
        let ftCalendar = ftDatePicker.calendar
        ftDateComponent = (ftCalendar?.dateComponents([.day, .hour, .minute, .second], from: ftDate))!
        let trigger = UNCalendarNotificationTrigger(dateMatching: ftDateComponent, repeats: true)
        
// 4: Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
// 5. Register the notification
        center.add(request)
        {
            (error) in
        }
//        print("date:\(ftDate)")
//        print("ftDateComponent:\(ftDateComponent)")
    }

// 6. Get the date componenets to update the time for countdown.
// A variable when declared and initialized can also be put in a function as below to use the return value
    var ftCountDown: DateComponents
    {
        return Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(),
                                               to: ftDatePicker.date)
    }

// 7. Timer for Countdown is updated and displayed onto the ftCountDownLabel
// An if statement is added to invalidate time if the seconds and minutes are equal to or less than 0.
    
    @objc func ftUpdateTimer()
    {

        let ftDay  = ftCountDown.day!
        let ftHour = ftCountDown.hour!
        let ftMinute = ftCountDown.minute!
        let ftSecond = ftCountDown.second!

//      print("Coming into ftUpdateTimer")
      print("Second:\(ftSecond)")
        ftCountDownLabel.text = String(format: "%02d:%02d:%02d:%02d", ftDay, ftHour, ftMinute, ftSecond)

        if(ftDay == 0 && ftHour == 0 && ftMinute <= 0 && ftSecond <= 0)
        {
//            print("-------------------------Entering invalidate-----------------------")
            timer?.invalidate()
            return
        }
    }

/*
     8. Time in invalidated and Timer scheduled is used to call ftUpdateTimer function to update time
     Function runFtCountDown() is started by invalidating the time first, what that means is that if there is
     already an occurence of time running, then current time invalidated, before a new instance of time can
     be started.
     Not invalidating time properly, can have mulitple instances of time running at the same time causing the
     program to use more memory.
*/
    func runFtCountdown()
    {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ftUpdateTimer),
                                     userInfo: nil, repeats: true)
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
