//
//  BaseView.swift
//  resturantApp
//
//  Created by Mohammad Butt on 10/18/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//
// Credits: Gary Tokman www.youtube.com/playlist?list=PLgwcD-3WBz9lQ5NgVon61nEiFRoxs5kAT

import UIKit

@IBDesignable class BaseView: UIView
{
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    func configure()
    {
        
    }
}
