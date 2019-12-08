//
//  Snake.swift
//  Snake
//
//  Created by Сергей Зесли on 08.12.2019.
//  Copyright © 2019 Сергей Зесли. All rights reserved.
//

import UIKit
import SpriteKit

class Snake: SKShapeNode {
    var body = [SnakeBodyPart]()
    
    convenience init(atPoint point: CGPoint) {
        self.init()
        let head = SnakeHead(atPoint: point)
        body.append(head)
        addChild(head)
    }
    
    func addBodyPart() {
        let newBodyPart = SnakeBodyPart(atPoint: CGPoint(x: body[0].position.x, y: body[0].position.y))
        body.append(newBodyPart)
        addChild(newBodyPart)
    }

}
