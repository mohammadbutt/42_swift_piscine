//
//  BaseView.swift
//  resturantApp
//
//  Created by Mohammad Butt on 10/18/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//

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
