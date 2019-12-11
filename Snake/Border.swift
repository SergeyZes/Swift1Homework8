//
//  Border.swift
//  Snake
//
//  Created by Сергей Зесли on 10.12.2019.
//  Copyright © 2019 Сергей Зесли. All rights reserved.
//

import UIKit
import SpriteKit

class Border: SKShapeNode {
    convenience init(position: CGPoint, size: CGSize) {
        self.init()
        path = UIBezierPath(rect: CGRect(x: position.x, y: position.y, width: size.width, height: size.height)).cgPath
        fillColor = UIColor.yellow
        strokeColor = UIColor.yellow
        lineWidth = 1
        //self.position = position
        //self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody = SKPhysicsBody(rectangleOf: size, center: CGPoint(x: position.x + size.width/2, y: position.y + size.height/2))
        self.physicsBody?.isDynamic=false

        
        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
    }

}
