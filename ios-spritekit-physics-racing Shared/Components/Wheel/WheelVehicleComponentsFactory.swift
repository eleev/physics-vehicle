//
//  WheelVehicleComponentsFactory.swift
//  ios-spritekit-physics-racing iOS
//
//  Created by Astemir Eleev on 10/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct WheelVehicleComponentsFactory {
    
    /// Produces a vechicle wheel with physics-based suspention
    ///
    /// - Parameters:
    ///     - builder: is a WheelBuilder that holds all the configuration for a wheel
    /// - Returns: a SKSpriteNode that represents a vehicle wheel and can be fither used as a component
    func produce(using builder: WheelBuilder) -> SKSpriteNode {
        
        let wheel = SKSpriteNode(texture: builder.texture, size: builder.size)
        wheel.zPosition = builder.zPostiion
        wheel.position = builder.position
        wheel.physicsBody = SKPhysicsBody(texture: builder.texture, alphaThreshold: 0.0, size: wheel.size)
        wheel.physicsBody?.allowsRotation = builder.allowsRotation
        
        return wheel
    }
    
    func produceShockPost() -> SKSpriteNode {
        fatalError()
    }
    
    func produceSlideJoint() -> SKPhysicsJointSliding {
        fatalError()
    }
    
    func produceSpringJoint() -> SKPhysicsJointSpring {
        fatalError()
    }
    
    func procudePinJoint() -> SKPhysicsJointPin {
        fatalError()
    }
}
