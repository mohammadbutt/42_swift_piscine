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
    
    @IBAction func ftStartButton(_ sender: UIButton)
    {
        print("Hello")
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
        let trigger = UNCalendarNotificationTrigger(dateMatching: ftDateComponent, repeats: false)
        
// 4: Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
// 5. Register the notification
        center.add(request)
        {
            (error) in
        }
        print("date:\(ftDate)")
        print("ftDateComponent:\(ftDateComponent)")
    }
 
    var ftCountDown: DateComponents
    {
        return Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(),
                                               to: ftDatePicker.date)
    }
    @objc func ftUpdateTimer()
    {
        let ftDay  = ftCountDown.day!
        let ftHour = ftCountDown.hour!
        let ftMinute = ftCountDown.minute!
        let ftSecond = ftCountDown.second!
        
        if (ftDay >= 0 && ftHour >= 0 && ftMinute >= 0 && ftSecond >= 0)
        {
        ftCountDownLabel.text = String(format: "%02d:%02d:%02d:%02d", ftDay, ftHour, ftMinute, ftSecond)
        }
        print("day:\(ftDay)")
        print("Hour:\(ftHour)")
        print("Minute:\(ftMinute)")
        print("Second:\(ftSecond)")
    }
    func runFtCountdown()
    {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ftUpdateTimer), userInfo: nil, repeats: true)
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

