//
//  Vehicle.swift
//  ios-spritekit-physics-racing iOS
//
//  Created by Astemir Eleev on 14/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

class Vehicle: SKNode {
    
    // MARK: - Properties
    
    private var joints: [SKPhysicsJoint]
    private var chasis: ChasisNode
    private var wheels: [PhysicsWheel]
    
    // MARK: - Initializers
    
    init(position: CGPoint, chasis: ChasisNode, wheels: [PhysicsWheel]) {
        joints = []
        self.wheels = wheels
        self.chasis = chasis
        
        for wheel in wheels {
            let suspernsion = wheel.suspension
            joints += [suspernsion.pinJoint, suspernsion.slideJoint, suspernsion.springJoint]
        }
        
        super.init()
        addChild(chasis)
        
        for wheel in wheels {
            addChild(wheel.sprite)
            addChild(wheel.suspension.shockPost)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func change(position: CGPoint) {
        chasis.position = position
    }
    
    func moveForward() {
        move(impulse: CGVector(dx: 32, dy: 0), angularImpulse: -0.01)
    }
    
    func moveBackward() {
        move(impulse: CGVector(dx: -10, dy: 0), angularImpulse: 0.01)
    }
    
    func leftTilt() {
        let point = CGPoint(x: -(chasis.size.width / 2 - 60), y: chasis.size.height / 4)
        tilt(at: point)
    }
    
    func rightTilt() {
        let point = CGPoint(x: chasis.size.width / 2 - 60, y: chasis.size.height / 4)
        tilt(at: point)
    }
    
    // MARK: - Private mehtods
    
    private func move(impulse: CGVector, angularImpulse: CGFloat) {
        let chasisZRotation = chasis.zRotation.toDegrees
        
        if chasisZRotation > -90, chasisZRotation > -270 {
            for wheel in wheels {
                wheel.sprite.physicsBody?.applyImpulse(impulse)
            }
        }
        
        for wheel in wheels {
            wheel.sprite.physicsBody?.applyAngularImpulse(angularImpulse)
        }
    }
    
    private func tilt(at point: CGPoint) {
        let convertedPoint = chasis.convert(point, to: self)
        
        let angle = chasis.zRotation - CGFloat.pi / 2
        let x = cos(angle)
        let y = sin(angle)
        let forceFactor: CGFloat = 1200
        
        chasis.physicsBody?.applyForce(CGVector(dx: x * forceFactor, dy: y * forceFactor), at: convertedPoint)
    }
}
