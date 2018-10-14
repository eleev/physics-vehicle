//
//  Wheel.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 14/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct Wheel {
    
    // MARK: - Properties
    
    private(set) var sprite: SKSpriteNode
    private(set) var suspension: WheelSuspension
    
    // MARK: - Initializers
    
    init(builder: WheelBuilder, suspension: WheelSuspension) {
        self.suspension = suspension
        
        sprite = SKSpriteNode(texture: builder.texture, size: builder.size)
        sprite.zPosition = builder.zPostiion
        sprite.position = builder.position
        sprite.physicsBody = SKPhysicsBody(texture: builder.texture, alphaThreshold: 0.0, size: sprite.size)
        sprite.physicsBody?.allowsRotation = builder.allowsRotation
    }
}
