//
//  ResturantTableViewCell.swift
//  resturantApp
//
//  Created by Mohammad Butt on 10/18/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//
// Credits: Gary Tokman www.youtube.com/playlist?list=PLgwcD-3WBz9lQ5NgVon61nEiFRoxs5kAT

import UIKit
import AlamofireImage

class ResturantTableViewCell: UITableViewCell
{
    @IBOutlet weak var resturantImageView: UIImageView!
    @IBOutlet weak var makerImageView: UIImageView!
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
    
    func configure(with viewModel: ResturantListViewModel)
    {
        resturantImageView.af_setImage(withURL: viewModel.imageUrl)
        resturantNameLabel.text = viewModel.name
        locationLabel.text = viewModel.distance
    }
    
}
