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
    
    private(set) var joints: [SKPhysicsJoint]
    private(set) var chasis: ChasisNode
    private(set) var wheels: [PhysicsWheel]
    private(set) var engine: Engine
    
    // MARK: - Initializers
    
    init(position: CGPoint, chasis: ChasisNode, engine: Engine, wheels: [PhysicsWheel]) {
        joints = []
        self.wheels = wheels
        self.engine = engine
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
        // 32
        move(impulse: CGVector(dx: engine.forwardPower(), dy: 0), angularImpulse: -0.01)
    }
    
    func `break`() {
        breakMovement()
    }
    
    func moveBackward() {
        // -10
        move(impulse: CGVector(dx: engine.backwardPower(), dy: 0), angularImpulse: 0.01)
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
            wheel.sprite.physicsBody?.applyForce(CGVector.init(dx: 0, dy: -9.8))
            
            let velocity = wheel.sprite.physicsBody?.velocity
            
            let forwardSpeed = engine.forwardSpeed()
            if velocity?.dx ?? 0.0 > forwardSpeed {
                wheel.sprite.physicsBody?.velocity.dx = forwardSpeed
            }
            
            let backwardSpeed = engine.backwardSpeed()
            if velocity?.dx ?? 0.0 < backwardSpeed {
                wheel.sprite.physicsBody?.velocity.dx = backwardSpeed
            }
        }
    }
    
    private func tilt(at point: CGPoint) {
        let convertedPoint = chasis.convert(point, to: self)
        
        let angle = chasis.zRotation - CGFloat.pi / 2
        let x = cos(angle)
        let y = sin(angle)
        let forceFactor: CGFloat = 1500
        
        chasis.physicsBody?.applyForce(CGVector(dx: x * forceFactor, dy: y * forceFactor), at: convertedPoint)
    }
    
    private func breakMovement() {
        print(#function)
        
        for wheel in wheels {
            wheel.sprite.physicsBody?.applyForce(CGVector.init(dx: 0, dy: -9.8 * 350))
            
            wheel.sprite.physicsBody?.angularVelocity /= CGFloat.greatestFiniteMagnitude
            
//            wheel.sprite.physicsBody?.velocity = .zero
            
            let velocity = wheel.sprite.physicsBody?.velocity
            wheel.sprite.physicsBody?.velocity = CGVector(dx: velocity?.dx ?? 1.0 / CGFloat.greatestFiniteMagnitude, dy: velocity?.dy ?? 1.0 / CGFloat.greatestFiniteMagnitude)
        }
    }
}
