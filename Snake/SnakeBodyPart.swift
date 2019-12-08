//
//  SnakeBodyPart.swift
//  Snake
//
//  Created by Сергей Зесли on 08.12.2019.
//  Copyright © 2019 Сергей Зесли. All rights reserved.
//

import UIKit
import SpriteKit

class SnakeBodyPart: SKShapeNode {
    let diameter = 10.0
    
    init(atPoint point: CGPoint) {
        super.init()
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: CGFloat(diameter), height: CGFloat(diameter))).cgPath
        fillColor = UIColor.green
        strokeColor = UIColor.green
        lineWidth = 5
        self.position = point
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
