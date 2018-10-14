//
//  ChasisVehicleFactory.swift
//  ios-spritekit-physics-racing iOS
//
//  Created by Astemir Eleev on 10/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct ChasisVehicleFactory {
    
    /// Constructs a physics-based chasis of a vechicle
    ///
    /// - Parameters:
    ///     - builder: is a ChasisBuilder that holds all the chasis configuration
    /// - Returns: a SKSpriteNode component that represents a vehicle's chasis and can be futher used as a vehicle's component
    func produce(using builder: ChasisBuilder) -> SKSpriteNode {
        let chasis = SKSpriteNode(texture: builder.texture, size: builder.size)
        chasis.zPosition = builder.zPosition
        chasis.position = builder.position
        chasis.physicsBody = SKPhysicsBody(texture: builder.texture, alphaThreshold: 0.0, size: chasis.size)
        
        return chasis
    }
}
