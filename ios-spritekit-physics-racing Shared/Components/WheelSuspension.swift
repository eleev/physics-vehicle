//
//  WheelSuspension.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 14/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct WheelSuspension {
    
    // MARK: - Properties
    
    private(set) var shockPost: SKSpriteNode
    private(set) var slideJoint: SKPhysicsJointSliding
    private(set) var springJoint: SKPhysicsJointSpring
    private(set) var pinJoint: SKPhysicsJointPin
    
    // MARK: - Initializers
    
    init(builder: WheelSuspensionBuilder) {
        shockPost = SKSpriteNode(color: builder.shockPostColor, size: builder.shockPostSize)
        shockPost.position = builder.shockPostPosition
        shockPost.physicsBody = SKPhysicsBody(rectangleOf: shockPost.size)
        
        fatalError()
    }
}
