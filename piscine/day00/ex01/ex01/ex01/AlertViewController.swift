//
//  AltertViewController.swift
//  ex01
//
//  Created by Mohammad Butt on 10/7/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController
{

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func pressedCancel(_ sender: Any)
    {
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
