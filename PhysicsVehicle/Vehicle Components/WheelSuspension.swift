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
    
    init?(builder: WheelSuspensionBuilder, attachmentBody body: ChasisNode, attachmentWheel wheel: WheelNode) {
        shockPost = SKSpriteNode(color: builder.shockPostColor, size: builder.shockPostSize)
        shockPost.position = builder.shockPostPosition
        shockPost.physicsBody = SKPhysicsBody(rectangleOf: shockPost.size)
        
        guard let bodyPhysics = body.physicsBody, let wheelPhysics = wheel.physicsBody else {
            return nil
        }        
        slideJoint = SKPhysicsJointSliding.joint(withBodyA: bodyPhysics,
                                                 bodyB: shockPost.physicsBody!,
                                                 anchor: shockPost.position,
                                                 axis: CGVector(dx: 0, dy: 1))
        slideJoint.shouldEnableLimits = true
        slideJoint.lowerDistanceLimit = builder.slideLoweLimit
        slideJoint.upperDistanceLimit = builder.wheelOffset.y
        
        springJoint = SKPhysicsJointSpring.joint(withBodyA: bodyPhysics,
                                                 bodyB: wheelPhysics,
                                                 anchorA: builder.springAttachmentPoint,
                                                 anchorB: wheel.position)
        springJoint.damping = builder.dapming
        springJoint.frequency = builder.frequiency
        
        pinJoint = SKPhysicsJointPin.joint(withBodyA: shockPost.physicsBody!,
                                           bodyB: wheelPhysics,
                                           anchor: wheel.position)
    }
    
    init?(builder: WheelSuspensionBuilder, attachmentBody body: ChasisNode, wheelPosition: CGPoint, wheelPhysicsBody: SKPhysicsBody) {
        shockPost = SKSpriteNode(color: builder.shockPostColor, size: builder.shockPostSize)
        shockPost.position = builder.shockPostPosition
        shockPost.physicsBody = SKPhysicsBody(rectangleOf: shockPost.size)
        
        guard let bodyPhysics = body.physicsBody else {
            return nil
        }
        slideJoint = SKPhysicsJointSliding.joint(withBodyA: bodyPhysics,
                                                 bodyB: shockPost.physicsBody!,
                                                 anchor: shockPost.position,
                                                 axis: CGVector(dx: 0, dy: 1))
        slideJoint.shouldEnableLimits = true
        slideJoint.lowerDistanceLimit = builder.slideLoweLimit
        slideJoint.upperDistanceLimit = builder.wheelOffset.y
        
        springJoint = SKPhysicsJointSpring.joint(withBodyA: bodyPhysics,
                                                 bodyB: wheelPhysicsBody,
                                                 anchorA: builder.springAttachmentPoint,
                                                 anchorB: wheelPosition)
        springJoint.damping = builder.dapming
        springJoint.frequency = builder.frequiency
        
        pinJoint = SKPhysicsJointPin.joint(withBodyA: shockPost.physicsBody!,
                                           bodyB: wheelPhysicsBody,
                                           anchor: wheelPosition)
    }
}
