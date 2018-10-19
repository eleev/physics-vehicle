//
//  WheelNode.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 15/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

class WheelNode: SKSpriteNode {
    
    init(builder: WheelBuilder) {
        super.init(texture: builder.texture, color: .clear, size: builder.size)
        
        zPosition = builder.zPostiion
        position = builder.position
        physicsBody = SKPhysicsBody(texture: builder.texture, alphaThreshold: 0.0, size: self.size)
        physicsBody?.allowsRotation = builder.allowsRotation
        physicsBody?.friction = builder.friction
        physicsBody?.usesPreciseCollisionDetection = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
