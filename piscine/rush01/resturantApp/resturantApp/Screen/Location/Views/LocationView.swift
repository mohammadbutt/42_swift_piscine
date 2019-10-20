//
//  LocationView.swift
//  resturantApp
//
//  Created by Mohammad Butt on 10/18/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//
// Credits: Gary Tokman www.youtube.com/playlist?list=PLgwcD-3WBz9lQ5NgVon61nEiFRoxs5kAT

import UIKit

@IBDesignable class LocationView: BaseView
{
    @IBOutlet weak var allowButton: UIButton!
    @IBOutlet weak var denyButton: UIButton!
    
    
    var didTapAllow: (() -> Void)?
    
    @IBAction func allowAction(_ sender: UIButton)
    {
        didTapAllow?()
    }
    
    @IBAction func denyAction(_ sender: UIButton)
    {
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
