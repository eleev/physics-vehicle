//
//  VehicleProtocol.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 29/07/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

protocol VehicleProtocol: AnyObject {
    var joints: [SKPhysicsJoint] { get }
    var chasis: SKSpriteNode { get }

    init(position: CGPoint)

    func applyForwardImpulse()
    func applyBackwardImpulse()
    func applyLeftTilt()
    func applyRightTilt()
}
