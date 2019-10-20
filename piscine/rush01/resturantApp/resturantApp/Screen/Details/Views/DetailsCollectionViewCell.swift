//
//  DetailsCollectionViewCell.swift
//  resturantApp
//
//  Created by Mohammad Butt on 10/20/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//

import Foundation
import UIKit

class DetailsCollectionViewCell: UICollectionViewCell
{
    let imageView = UIImageView()
    
    override init(frame: CGRect)
    {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup()
    {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
        ])
    }
}
