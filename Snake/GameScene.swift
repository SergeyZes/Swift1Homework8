//
//  GameScene.swift
//  Snake
//
//  Created by Сергей Зесли on 07.12.2019.
//  Copyright © 2019 Сергей Зесли. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var tchNode: SKShapeNode?
    var snake: Snake?
    
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor.black
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.allowsRotation = false
        //view.showsPhysics = true
        self.physicsWorld.contactDelegate = self
        
        let counterClockwiseButton = SKShapeNode()
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockwiseButton.position = CGPoint(x: view.scene!.frame.minX + 30, y: view.scene!.frame.minY + 30)
        counterClockwiseButton.fillColor = UIColor.gray
        counterClockwiseButton.strokeColor = UIColor.gray
        counterClockwiseButton.lineWidth = 10
        counterClockwiseButton.name = "counterClockwiseButton"
        self.addChild(counterClockwiseButton)
        
        let clockwiseButton = SKShapeNode()
        clockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockwiseButton.position = CGPoint(x: view.scene!.frame.maxX - 80, y: view.scene!.frame.minY + 30)
        clockwiseButton.fillColor = UIColor.gray
        clockwiseButton.strokeColor = UIColor.gray
        clockwiseButton.lineWidth = 10
        clockwiseButton.name = "clockwiseButton"
        self.addChild(clockwiseButton)

        createApple()
        
        print("\(counterClockwiseButton.position.x)  \(counterClockwiseButton.position.y)")
        
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        self.addChild(snake!)
        
        let downEdge = Border(position: CGPoint(x: 0, y: 100), size: CGSize(width: view.scene!.frame.width, height: 5))
        self.addChild(downEdge)
        let topEdge = Border(position: CGPoint(x: 0, y: view.scene!.frame.maxY-40), size: CGSize(width: view.scene!.frame.width, height: 5))
        self.addChild(topEdge)
        
        let leftEdge = Border(position: CGPoint(x: 0, y: 100), size: CGSize(width: 5, height: view.scene!.frame.maxY-140))
        self.addChild(leftEdge)
        
        let rightEdge = Border(position: CGPoint(x: view.scene!.frame.width-5, y: 100), size: CGSize(width: 5, height: view.scene!.frame.maxY-140))
        self.addChild(rightEdge)


        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        self.physicsBody?.collisionBitMask = CollisionCategories.Snake | CollisionCategories.SnakeHead
   }
    
        
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchesNode = self.atPoint(touchLocation) as? SKShapeNode, touchesNode.name == "counterClockwiseButton" || touchesNode.name == "clockwiseButton" else {
               return
            }
            
            touchesNode.fillColor = .green
            
            if touchesNode.name == "counterClockwiseButton" {
                snake!.moveCounterClockwise()
            } else if touchesNode.name == "clockwiseButton" {
                snake!.moveClockwise()
            }
            
            tchNode =  touchesNode
        }
 
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        tchNode?.fillColor = .gray
        tchNode = nil
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchesNode = self.atPoint(touchLocation) as? SKShapeNode, touchesNode.name == "counterClockwiseButton" || touchesNode.name == "clockwiseButton" else {
               return
            }
            
            touchesNode.fillColor = .gray
        }

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        tchNode?.fillColor = .gray
        tchNode = nil

    }
    
    
    override func update(_ currentTime: TimeInterval) {
        snake!.move()
    }
    
    func createApple() {
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX - 5)) + 1)
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY - 5)) + 1)
        
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        self.addChild(apple)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let bodies = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let collisionObject = bodies ^ CollisionCategories.SnakeHead
        
        switch collisionObject {
        case CollisionCategories.Apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake?.addBodyPart()
            apple?.removeFromParent()
            createApple()
        default:
            break
        }
    }
}

struct CollisionCategories  {
    static let Snake: UInt32 = 0x1 << 0
    static let SnakeHead: UInt32 = 0x1 << 1
    static let Apple: UInt32 = 0x1 << 2
    static let EdgeBody: UInt32 = 0x1 << 3
}
