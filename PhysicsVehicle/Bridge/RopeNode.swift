//
//  RopeNode.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 19/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

class RopeNode: SKNode {
    
    // MARK: - Properties
    
    private var ropes = [ChainNode]()
    
    var head: ChainNode? {
        get {
            return ropes.first
        }
    }
    
    var tail: ChainNode? {
        get {
            return ropes.last
        }
    }
    
    // MARK: - Initializers
    
    init(with length: CGFloat, and texture: SKTexture, anchorDestination: CGPoint = .zero) {
        super.init()
        
        let num = Int(ceil(length))
        
        for index in 0...num-1 {
            let floatIndex = CGFloat(index)
            let node = ChainNode(nodeTexture: texture)
            node.position.x = floatIndex * node.size.width
            
            if anchorDestination != .zero {
                node.position.y = floatIndex * node.size.width + anchorDestination.y / 2
            }
            
            addChild(node)
            ropes.append(node)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func attach(to node: SKNode) {
        guard let attachmentBody = node.physicsBody, let scene = node.scene, ropes.count > 0, let parent = node.parent, let head = head?.physicsBody else {
            fatalError()
        }
        let midx = node.frame.midX
        let midy = node.frame.midY
        let point = CGPoint(x: midx, y: midy)
        
        let attachmentPoint = scene.convert(point, from: parent)
        let joint = SKPhysicsJointPin.joint(withBodyA: attachmentBody, bodyB: head, anchor: attachmentPoint)
        node.addChild(self)
        
        let world = scene.physicsWorld
        world.add(joint)
        constructPhysics(in: world)
    }
    
    func anchor(to node: SKNode) {
        guard let attachmentBody = node.physicsBody, let scene = node.scene, ropes.count > 0, let tailPhysics = tail?.physicsBody else {
            fatalError()
        }
        
        let joint = SKPhysicsJointPin.joint(withBodyA: tailPhysics, bodyB: attachmentBody, anchor: node.position)
        joint.shouldEnableLimits = true
        joint.lowerAngleLimit = 0
        joint.upperAngleLimit = 0
        
        scene.physicsWorld.add(joint)
    }

    func attach(anchor textureRepresentation: SKTexture) {
        guard let tailPosition = tail?.position, let unwrappedTail = tail, let scene = scene else {
            fatalError()
        }
        let spriteRopeNode = ChainNode(nodeTexture: textureRepresentation)
        //        spriteRopeNode.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        spriteRopeNode.position = CGPoint(x: tailPosition.x, y: unwrappedTail.frame.midY)
        spriteRopeNode.physicsBody = SKPhysicsBody(circleOfRadius: spriteRopeNode.size.height / 2)
        spriteRopeNode.physicsBody?.mass = 0.5
        
        scene.addChild(spriteRopeNode)
        ropes.append(spriteRopeNode)
        
        let world = scene.physicsWorld
        constructPhysics(in: world)
    }
    
    
    // MARK: - Private methods
    
    private func constructPhysics(in world: SKPhysicsWorld) {
        guard let scene = scene else {
            fatalError()
        }
        
        for index in 0..<ropes.count - 1 {
            let nodeA = ropes[index]
            let nodeB = ropes[index + 1]
            
            guard let parentA = nodeA.parent, let physicsBodyA = nodeA.physicsBody, let physicsBodyB = nodeB.physicsBody else {
                continue
            }
            
            let midx = nodeA.frame.midX
            let midy = nodeA.frame.midY
            let point = CGPoint(x: midx, y: midy)
            let attachmentPoint = scene.convert(point, from: parentA)
            
            let joint = SKPhysicsJointPin.joint(withBodyA: physicsBodyA, bodyB: physicsBodyB, anchor: attachmentPoint)
            joint.shouldEnableLimits = true
            joint.lowerAngleLimit = 360.degreesToRadians
            joint.upperAngleLimit = 360.degreesToRadians
                    
            world.add(joint)
        }
    }
    
}
