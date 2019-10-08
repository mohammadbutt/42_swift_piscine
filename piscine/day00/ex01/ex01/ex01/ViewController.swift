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
 size relationally to the other elements of the page. ✔
 
 2.A UILabel with text describing how awesome you are inside of it, that changes
 between two fonts depending on which button was pressed. ✔
 
 3.A popup notification that alerts us to when a font was changed. ✔
 
 Pro Tip: Look up StackView, and see if you want to use it with autolayout.
*/

/*
 To adapt to the rotation of the screen: Click on "Show the Object Library" in
 utilities.
 1. Click and drop "Vertical Stack View" in the storyboard and adjust the size of
 the view.
 2. Click on "Align" found right below the storyboard. Check mark the below:
    2.a. Horizontally in container.
    2.b. Vertically in container.
 3. Click on "Add New constraints" found right next to Align in the storyboard
 and check mark the below:
    3.a. Width.
    3.b. Height.
 4. Drag and drop UILabel and UIButton inside Vertical Stack View.
*/

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var ftUILabel: UILabel!
    
// Below is the notification alert function
    func showAlert(headerTitle:String, bodyMessage:String, dismiss:String)
    {
        let alert = UIAlertController(title: headerTitle, message: bodyMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: dismiss, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
// Above is the notification alert function

    @IBAction func ftUIButton1(_ sender: UIButton)
    {
        ftUILabel.font = UIFont.systemFont(ofSize: 20.0)
        showAlert(headerTitle: "Notification", bodyMessage: "Font is changed to 20.0", dismiss: "Ok")
    }
    
    @IBAction func ftUIButton2(_ sender: UIButton)
    {
        ftUILabel.font = UIFont.systemFont(ofSize: 15.0)
        showAlert(headerTitle: "Notification", bodyMessage: "Font is chanegd to 15.0", dismiss: "Ok")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

