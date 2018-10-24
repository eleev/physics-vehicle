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
        
        
//        var chasisZRotation = chasis.zRotation.toDegrees + 90
//
//        if chasisZRotation < 0 {
//            chasisZRotation = -chasisZRotation
//        }
//
//        debugPrint("chasis z rotation: ", chasisZRotation)
//        let dx = CGFloat(cosf(Float(chasisZRotation)))
//        debugPrint("dx: ", dx)
//
//        let dy = CGFloat(sinf(Float(chasisZRotation)))
//        debugPrint("dy: ", dy)
//
//        let vector = CGVector(dx: dx * impulse.dx, dy: dy)
//        debugPrint("vector: ", vector)
        
        
//        for wheel in wheels {
//            guard let deltaX = wheel.sprite.physicsBody?.velocity.dx, let deltaY = wheel.sprite.physicsBody?.velocity.dy else {
//                continue
//            }
//            wheel.sprite.physicsBody?.applyAngularImpulse(angularImpulse)
//            wheel.sprite.physicsBody?.applyTorque(angularImpulse * 10)
//
//            let forwardSpeed = engine.forwardSpeed()
//            let deltaZ = sqrt(pow(deltaX, 2) + pow(deltaY, 2))
//
//            if deltaZ > forwardSpeed {
//                debugPrint("velocity correction / f")
//                let xProportion = deltaX / deltaZ
//                let yProportion = deltaY / deltaZ
//
//                let correctedDeltaX = xProportion * forwardSpeed
//                let correctedDeltaY = yProportion * forwardSpeed
//                wheel.sprite.physicsBody?.velocity = CGVector(dx: correctedDeltaX, dy: correctedDeltaY)
//            }
//            let backwardSpeed = engine.backwardSpeed()
//
//            if deltaZ > backwardSpeed {
//                debugPrint("velocity correction / b")
//                let xProportion = deltaX / deltaZ
//                let yProportion = deltaY / deltaZ
//
//                let correctedDeltaX = xProportion * backwardSpeed
//                let correctedDeltaY = yProportion * backwardSpeed
//                wheel.sprite.physicsBody?.velocity = CGVector(dx: correctedDeltaX, dy: correctedDeltaY)
//            }
//
//            debugPrint(" ")
//        }
        
        // -------------
        
        
        let chasisZRotation = chasis.zRotation.toDegrees
        debugPrint("degrees: ", chasisZRotation)
        
        if chasisZRotation > -70, chasisZRotation < 70 {
            debugPrint("if")
            for wheel in wheels {
                wheel.sprite.physicsBody?.applyImpulse(impulse)
                
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

        for wheel in wheels {
            wheel.sprite.physicsBody?.applyAngularImpulse(angularImpulse)
//            wheel.sprite.physicsBody?.applyForce(CGVector.init(dx: 0, dy: -9.8))

//            let velocity = wheel.sprite.physicsBody?.velocity
//
//            let forwardSpeed = engine.forwardSpeed()
//            if velocity?.dx ?? 0.0 > forwardSpeed {
//                wheel.sprite.physicsBody?.velocity.dx = forwardSpeed
//            }
//
//            let backwardSpeed = engine.backwardSpeed()
//            if velocity?.dx ?? 0.0 < backwardSpeed {
//                wheel.sprite.physicsBody?.velocity.dx = backwardSpeed
//            }
        }
    }
    
    private func tilt(at point: CGPoint) {
        let convertedPoint = chasis.convert(point, to: self)
        
        let angle = chasis.zRotation - CGFloat.pi / 2
        let x = cos(angle)
        let y = sin(angle)
        let forceFactor: CGFloat = 2000
        
        chasis.physicsBody?.applyForce(CGVector(dx: x * forceFactor, dy: y * forceFactor), at: convertedPoint)
    }
    
    private func breakMovement() {
//        chasis.physicsBody?.applyTorque(-500)
        
        for wheel in wheels where wheel.isBreakable  {
            wheel.sprite.physicsBody?.angularVelocity /= CGFloat.greatestFiniteMagnitude
            wheel.sprite.physicsBody?.velocity = .zero
        }
    }
}
