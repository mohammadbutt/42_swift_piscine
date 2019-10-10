//
//  Emitter.swift
//  ex02
//
//  Created by Mohammad Butt on 10/9/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
// reference: www.youtube.com/watch?v=Cg5GzKsMF7M
//

import UIKit

class Emitter
{
    static func get(with image1: UIImage) -> CAEmitterLayer
    {
        let emitter = CAEmitterLayer()
        emitter.emitterShape = kCAEmitterLayerLine
        emitter.emitterCells = generateEmitterCellsImage1(with: image1)
        return emitter
    }
    
    static func generateEmitterCellsImage1(with image1: UIImage) -> [CAEmitterCell]
    {
        var cells = [CAEmitterCell]()
        let cell = CAEmitterCell()
        cell.contents = image1.cgImage
        cell.birthRate = 5
        cell.lifetime = 8
        cell.velocity = 100
        cell.emissionLongitude = (180 * (.pi/180))
        cell.emissionRange = (30 * (.pi / 180))
        cell.scale = 0.4
        cell.scaleRange = 0.5
        cell.yAcceleration = 0.5
        cell.zAcceleration = 3.0
        cell.spinRange = 3.6
        cells.append(cell)
        return cells
    }
}
