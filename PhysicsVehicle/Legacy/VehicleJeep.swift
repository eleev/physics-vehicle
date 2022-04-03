//
//  VehicleJeep.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 29/07/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

class VehicleJeep: SKNode, VehicleProtocol {
    
    var joints = [SKPhysicsJoint]()
    var chasis: SKSpriteNode
    var leftWheel: SKSpriteNode
    var rightWheel: SKSpriteNode
    
    required init(position: CGPoint) {
        let wheelOffsetY: CGFloat = 65
        let damping: CGFloat = 0.75
        let frequiency: CGFloat = 5
        
        
        var bodyTexture: SKTexture!
        let carBodyImageName = "car-body"
        
        #if os(macOS)
        bodyTexture = SKTexture(image: NSImage(named: carBodyImageName)!)
        #endif
        
        #if os(iOS)
        bodyTexture = SKTexture(image: UIImage(named: carBodyImageName)!)
        #endif
        
        
        chasis = SKSpriteNode(texture: bodyTexture, size: CGSize(width: 400, height: 112.3))
        chasis.zPosition = 8
        chasis.position = position
        chasis.physicsBody = SKPhysicsBody(texture: bodyTexture, alphaThreshold: 0.0, size: chasis.size)
        
        
        var tireTexture: SKTexture!
        let carWheelImageName = "car-wheel"
        
        #if os(macOS)
        tireTexture = SKTexture(image: NSImage(named: carWheelImageName)!)
        #endif
        
        #if os(iOS)
        tireTexture = SKTexture(image: UIImage(named: carWheelImageName)!)
        #endif
        
        let tireSize = CGSize(width: 78, height: 78)
        
        leftWheel = SKSpriteNode(texture: tireTexture, size: tireSize)
        leftWheel.zPosition = 10
        leftWheel.position = CGPoint(x: (chasis.position.x - chasis.size.width / 2) + 68, y: chasis.position.y - wheelOffsetY)
        leftWheel.physicsBody = SKPhysicsBody(texture: tireTexture, alphaThreshold: 0.0, size: leftWheel.size)
        /*
        leftWheel.physicsBody = SKPhysicsBody(circleOfRadius: leftWheel.size.width / 2)
        */
        leftWheel.physicsBody?.allowsRotation = true
        
        
        rightWheel = SKSpriteNode(texture: tireTexture, size: tireSize)
        rightWheel.zPosition = 10
        rightWheel.position = CGPoint(x: (chasis.position.x + chasis.size.width / 2) - 72, y: chasis.position.y - wheelOffsetY)
        rightWheel.physicsBody = SKPhysicsBody(texture: tireTexture, alphaThreshold: 0.0, size: rightWheel.size)
        /*
        rightWheel.physicsBody = SKPhysicsBody(circleOfRadius: rightWheel.size.width / 2)
        */
        rightWheel.physicsBody?.allowsRotation = true
        
        // Left Suspention
        
        let leftShockPost = SKSpriteNode(color: .blue, size: CGSize(width: 7, height: wheelOffsetY))
        leftShockPost.position = CGPoint(x: (chasis.position.x - chasis.size.width / 2) + 68, y: chasis.position.y - leftShockPost.size.height / 2)
        leftShockPost.physicsBody = SKPhysicsBody(rectangleOf: leftShockPost.size)
        
        let leftSlide = SKPhysicsJointSliding.joint(withBodyA: chasis.physicsBody!, bodyB: leftShockPost.physicsBody!, anchor: CGPoint(x: leftShockPost.position.x, y: leftShockPost.position.y), axis: CGVector(dx: 0, dy: 1))
        leftSlide.shouldEnableLimits = true
        leftSlide.lowerDistanceLimit = 5
        leftSlide.upperDistanceLimit = wheelOffsetY
        
        let leftSpring = SKPhysicsJointSpring.joint(withBodyA: chasis.physicsBody!, bodyB: leftWheel.physicsBody!, anchorA: CGPoint(x: (chasis.position.x - chasis.size.width / 2) + 68, y: chasis.position.y), anchorB: leftWheel.position)
        leftSpring.damping = damping
        leftSpring.frequency = frequiency
        
        let leftPin = SKPhysicsJointPin.joint(withBodyA: leftShockPost.physicsBody!, bodyB: leftWheel.physicsBody!, anchor: leftWheel.position)
        
        
        // Right Suspension
        
        let rightShockPost = SKSpriteNode(color: .blue, size: CGSize(width: 7, height: wheelOffsetY))
        rightShockPost.position = CGPoint(x: (chasis.position.x + chasis.size.width / 2) - 72, y: chasis.position.y - rightShockPost.size.height / 2)
        rightShockPost.physicsBody = SKPhysicsBody(rectangleOf: rightShockPost.size)
        
        
        let rightSlide = SKPhysicsJointSliding.joint(withBodyA: chasis.physicsBody!, bodyB: rightShockPost.physicsBody!, anchor: CGPoint(x: rightShockPost.position.x, y: rightShockPost.position.y), axis: CGVector(dx: 0, dy: 1))
        rightSlide.shouldEnableLimits = true
        rightSlide.lowerDistanceLimit = 5
        rightSlide.upperDistanceLimit = wheelOffsetY
        
        let rightSpring = SKPhysicsJointSpring.joint(withBodyA: chasis.physicsBody!, bodyB: rightWheel.physicsBody!, anchorA: CGPoint(x: (chasis.position.x + chasis.size.width / 2) - 72, y: chasis.position.y), anchorB: rightWheel.position)
        rightSpring.damping = damping
        rightSpring.frequency = frequiency
        
        let rightPin = SKPhysicsJointPin.joint(withBodyA: rightShockPost.physicsBody!, bodyB: rightWheel.physicsBody!, anchor: rightWheel.position)
        
        // Add all the joints to the joints array
        
        /*
        joints += [joint]
        */
         
        joints += [leftSlide]
        joints += [leftSpring]
        joints += [leftPin]
        
        joints += [rightSlide]
        joints += [rightSpring]
        joints += [rightPin]
        
        super.init()
        
        addChild(chasis)
        addChild(leftWheel)
        addChild(rightWheel)
        addChild(leftShockPost)
        addChild(rightShockPost)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyJumpImpulse() {
        let orinetation = Float(zRotation * (CGFloat.pi / 2))
        let velocity: Float = 300
        let x = cosf(orinetation)
        let y = sinf(orinetation)
        let impulseVector = CGVector(dx: CGFloat(x * velocity), dy: CGFloat(y * velocity))
        
        chasis.physicsBody?.applyImpulse(impulseVector)
    }
    
    func applyForwardImpulse() {
        let chasisZRotation = chasis.zRotation.toDegrees
        
        if chasisZRotation > -90, chasisZRotation > -270 {
            let impulseVector = CGVector(dx: 22, dy: 0.0)
            leftWheel.physicsBody?.applyImpulse(impulseVector)
            rightWheel.physicsBody?.applyImpulse(impulseVector)
        }
        
        leftWheel.physicsBody?.applyAngularImpulse(-0.01)
        rightWheel.physicsBody?.applyAngularImpulse(-0.01)
    }
    
    func applyBackwardImpulse() {
        let chasisZRotation = chasis.zRotation.toDegrees
        
        if chasisZRotation > -90, chasisZRotation > -270 {
            let impulseVector = CGVector(dx: -10, dy: 0.0)
            leftWheel.physicsBody?.applyImpulse(impulseVector)
            rightWheel.physicsBody?.applyImpulse(impulseVector)
        }
        
        leftWheel.physicsBody?.applyAngularImpulse(0.01)
        rightWheel.physicsBody?.applyAngularImpulse(0.01)
    }
    
    func applyLeftTilt() {
        let point = CGPoint(x: -(chasis.size.width / 2 - 60), y: chasis.size.height / 4)
        let convertedPoint = chasis.convert(point, to: self)
        debugPrint("converted left point: ", convertedPoint)
        
        /*
        let node = SKShapeNode(circleOfRadius: 10)
        node.fillColor = .blue
        node.zPosition = 10000
        node.position = convertedPoint
        self.addChild(node)
        let actions = SKAction.sequence([SKAction.wait(forDuration: 2), SKAction.removeFromParent()])
        node.run(actions)
        */
         
        let angle = chasis.zRotation - CGFloat.pi / 2
        let x = cos(angle)
        let y = sin(angle)
        let forceFactor: CGFloat = 1200
        
        /*
        let convertedPoint = self.scene?.convert(point, from: chasis)
        let convertedPoint = self.scene?.view?.convert(point, to: scene!)
        */
         
        chasis.physicsBody?.applyForce(CGVector(dx: x * forceFactor, dy: y * forceFactor), at: convertedPoint)
    }
    
    func applyRightTilt() {
        let point = CGPoint(x: chasis.size.width / 2 - 60, y: chasis.size.height / 4)
        let convertedPoint = chasis.convert(point, to: self)
        debugPrint("converted right point: ", convertedPoint)
        
        /*
        let node = SKShapeNode(circleOfRadius: 10)
        node.fillColor = .red
        node.zPosition = 10000
        node.position = convertedPoint
        self.addChild(node)
        let actions = SKAction.sequence([SKAction.wait(forDuration: 2), SKAction.removeFromParent()])
        node.run(actions)
        */
         
        let angle = chasis.zRotation - CGFloat.pi / 2
        let x = cos(angle)
        let y = sin(angle)
        let forceFactor: CGFloat = 1200
        
        /*
        let convertedPoint = self.scene?.convert(point, from: chasis)
        let convertedPoint = self.scene?.view?.convert(point, to: scene!)
        */
        chasis.physicsBody?.applyForce(CGVector(dx: x * forceFactor, dy: y * forceFactor), at: convertedPoint)
    }
    
}
