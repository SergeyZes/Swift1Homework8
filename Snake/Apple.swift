//
//  Apple.swift
//  Snake
//
//  Created by Сергей Зесли on 08.12.2019.
//  Copyright © 2019 Сергей Зесли. All rights reserved.
//

import UIKit
import SpriteKit

class Apple: SKShapeNode {
    convenience init(position: CGPoint) {
        self.init()
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        fillColor = UIColor.red
        strokeColor = UIColor.red
        lineWidth = 5
        self.position = position
    }

}
