//
//  ResturantTableViewCell.swift
//  resturantApp
//
//  Created by Mohammad Butt on 10/18/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//

import UIKit

class ResturantTableViewCell: UITableViewCell
{
    @IBOutlet weak var resturantImageView: UIImage!
    @IBOutlet weak var makerImageView: UIImage!
    @IBOutlet weak var resturantNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
