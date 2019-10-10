//
//  ViewController.swift
//  ex03
//
//  Created by Mohammad Butt on 10/9/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//

/*
 Exercise 03: Dates & Times
 Allowed functions: Swift Standard Library, UIKit
 
 We are going to script an event to occur at a specific time, like a minimal alarm clock. A push notification
 will suffice.
*/

import UIKit

class ViewController: UIViewController
{
    var num = 20
    func showAlert(headerTitle: String, bodyMessage: String, dismissArea: String)
    {
        let alert = UIAlertController(title: headerTitle, message: bodyMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: dismissArea, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    if (num == 20)
    {
        showAlert(headerTitle: "Notification", bodyMessage: "This is a test", dismissArea: "ok")
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

