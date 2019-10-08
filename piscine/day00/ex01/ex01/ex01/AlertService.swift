//
//  AlertService.swift
//  ex01
//
//  Created by Mohammad Butt on 10/7/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//

import UIKit

class AlertService
{
    func alert() -> AlertViewController
    {
        let storyboard = UIStoryboard(name: "AlertStoryboard", bundle: .main)
        
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertVC") as!
            AlertViewController
        return alertVC
    }
}
