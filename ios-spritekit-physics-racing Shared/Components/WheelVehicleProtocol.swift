//
//  WheelVehicleProtocol.swift
//  ios-spritekit-physics-racing iOS
//
//  Created by Astemir Eleev on 10/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import Foundation

protocol WheelVehicleProtocol: VehicleProtocol {
    var leftWheel: SKSpriteNode { get }
    var rightWheel: SKSpriteNode { get }
    
    var wheelOffsetX: CGFloat { get }
    var wheelOffsetY: CGFloat { get }
    var damping: CGFloat { get }
    var frequency: CGFloat { get }
    var tireSize: CGSize { get }
    var tireTexture: SKTexture { get }
    
}

extension WheelVehicleProtocol {
    
    var leftWheel: SKSpriteNode {
        let leftWheel = SKSpriteNode(texture: tireTexture, size: tireSize)
        leftWheel.zPosition = 10
        leftWheel.position = CGPoint(x: (chasis.position.x - chasis.size.width / 2) + 68, y: chasis.position.y - wheelOffsetY)
        leftWheel.physicsBody = SKPhysicsBody(texture: tireTexture, alphaThreshold: 0.0, size: leftWheel.size)
        //        leftWheel.physicsBody = SKPhysicsBody(circleOfRadius: leftWheel.size.width / 2)
        leftWheel.physicsBody?.allowsRotation = true
        
        return leftWheel
    }
    
    var rightWheel: SKSpriteNode {
        let rightWheel = SKSpriteNode(texture: tireTexture, size: tireSize)
        rightWheel.zPosition = 10
        rightWheel.position = CGPoint(x: (chasis.position.x + chasis.size.width / 2) - 72, y: chasis.position.y - wheelOffsetY)
        rightWheel.physicsBody = SKPhysicsBody(texture: tireTexture, alphaThreshold: 0.0, size: rightWheel.size)
        //        rightWheel.physicsBody = SKPhysicsBody(circleOfRadius: rightWheel.size.width / 2)
        rightWheel.physicsBody?.allowsRotation = true
        
        return rightWheel
    }
}
