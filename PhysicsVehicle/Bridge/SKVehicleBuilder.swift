//
//  SKVehicleBuilder.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 19/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

class SKVehicleBuilder {
    
    private struct WheelSuspensionGenericBuilder: WheelSuspensionBuilder {
        
        var dapming: CGFloat
        var frequiency: CGFloat
        var wheelOffset: CGPoint
        var shockPostColor: SKColor
        var shockPostSize: CGSize
        var shockPostPosition: CGPoint
        var slideLoweLimit: CGFloat
        var springAttachmentPoint: CGPoint
    }
    
    // MARK: - Properties
    
    private(set) var tracks = [SKSpriteNode]()
    private(set) var wheels = [PhysicsWheel]()
    private(set) var chasis: ChasisNode?
    private let scene: SKScene
    private let targetScene: SKScene
    
    // MARK: - Initializers
    
    init(scene: SKScene, targetScene: SKScene) {
        self.scene = scene
        self.targetScene = targetScene
        
//        let horizontalNumber = Int(ceil(width / 50))
//        let verticalNumber = Int(ceil(height / 50))
//
//        for x in 0...horizontalNumber - 1 {
//            let floatIndexX = CGFloat(x)
//
//            for y in 0...verticalNumber - 1 {
//                let floatIndexY = CGFloat(y)
//
//                let chainNode = ChainNode(color: SKColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5), size: CGSize(width: 50, height: 10))
//                chainNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//
//                chainNode.position.x = floatIndexX * chainNode.size.width
//                chainNode.position.y = floatIndexY * chainNode.size.height
//
//                addChild(chainNode)
//                tracks.append(chainNode)
//            }
//        }
        
//        var physicalWidth: CGFloat = 0
        
//        for index in 0...horizontalNumber - 1 {
//
//            let floatIndex = CGFloat(index)
//            let chainNode = ChainNode(color: SKColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5), size: CGSize(width: 50, height: 10))
//
//            chainNode.position.x = floatIndex * chainNode.size.width
//            chainNode.position.y = height / 2
//
//            addChild(chainNode)
//            tracks.append(chainNode)
//        }
//
//        for index in (0...verticalNumber - 1).reversed() {
//            let floatIndex = CGFloat(index)
//            let chainNode = ChainNode(color: SKColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5), size: CGSize(width: 50, height: 10))
//            chainNode.zRotation = 90.degreesToRadians
//            chainNode.position.x = horizontalNumber - 1
//            chainNode.position.y = floatIndex * chainNode.size.width
//
//            addChild(chainNode)
//            tracks.append(chainNode)
//        }
//
//        for index in (0...horizontalNumber - 1).reversed() {
//            let floatIndex = CGFloat(index)
//            let chainNode = ChainNode(color: SKColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5), size: CGSize(width: 50, height: 10))
//            chainNode.position.x = floatIndex * chainNode.size.width
//            chainNode.position.y = -height / 2
//
//            addChild(chainNode)
//            tracks.append(chainNode)
//        }
        
        
        
    }
    
    func produce(at position: CGPoint) -> Vehicle {
        guard let vehicleNode = scene.childNode(withName: "Vehicle") else {
            fatalError("VehicleNode cannot be retreived")
        }
        vehicleNode.removeFromParent()
        
        guard let wheels = vehicleNode.childNode(withName: "Wheels") else {
            fatalError("Wheels cannot be retreived")
        }
        wheels.removeFromParent()
        
        guard let tracks = vehicleNode.childNode(withName: "Tracks") else {
            fatalError("Tracks cannot be retreived")
        }
        tracks.removeFromParent()
        
        guard let chasisSpriteNode = vehicleNode.childNode(withName: "Chasis") as? SKSpriteNode else {
            fatalError("ChasisNode cannot be constructed")
        }
        chasisSpriteNode.removeFromParent()
        
        chasis = ChasisNode(node: chasisSpriteNode)
        chasis?.zPosition = 10
        chasis?.physicsBody?.categoryBitMask = ContactCategory.chasis.rawValue
        chasis?.physicsBody?.collisionBitMask = ContactCategory.ground.rawValue | ContactCategory.bridge.rawValue
        
        guard let chasis = chasis else {
            fatalError("ChasisNdoe was not correctly constructed")
        }
        
        
        for wheel in wheels.children where wheel is SKSpriteNode {
//            let node = WheelNode(node: wheel as! SKSpriteNode)
            let node = SoftPhysicsWheel(position: .zero, size: CGSize(width: 100, height: 100), color: .orange)
            node.zPosition = 20
            node.physicsBody?.categoryBitMask = ContactCategory.wheel.rawValue
            node.physicsBody?.collisionBitMask = ContactCategory.ground.rawValue | ContactCategory.bridge.rawValue | ContactCategory.track.rawValue
            node.physicsBody?.friction = 1.5
            
            let wheelBuilder = WheelSuspensionGenericBuilder(dapming: 0.5,
                                                             frequiency: 3,
                                                             wheelOffset: wheel.position,
                                                             shockPostColor: .white,
                                                             shockPostSize: CGSize(width: 40, height: 70),
                                                             shockPostPosition: CGPoint(x: wheel.position.x, y: wheel.position.y + 20),
                                                             slideLoweLimit: 5,
                                                             springAttachmentPoint: CGPoint(x: wheel.position.x, y: chasis.position.y))
            
//            guard let suspension = WheelSuspension(builder: wheelBuilder, attachmentBody: chasis, attachmentWheel: node) else {
//                fatalError("WheelSuspension failed when constructed")
//            }
            guard let suspension = WheelSuspension(builder: wheelBuilder, attachmentBody: chasis, wheelPosition: node.position, wheelPhysicsBody: node.basePhysicsBody!) else {
                fatalError("WheelSuspension failed when constructed")
            }
            
            let physicsWheel = PhysicsWheel(node: node,
                                            suspension: suspension,
                                            isBreakable: true)
            self.wheels += [physicsWheel]
            break
        }
        
        guard let utracks = tracks.children as? [SKSpriteNode] else {
            fatalError("Could not unwrap SKSpriteNode tracks")
        }
        utracks.forEach { (node) in
            node.removeFromParent()
        }
//        for utrack in utracks {
//            utrack.physicsBody?.categoryBitMask = ContactCategory.track.rawValue
//            utrack.physicsBody?.collisionBitMask = ContactCategory.ground.rawValue | ContactCategory.bridge.rawValue | ContactCategory.wheel.rawValue
//            utrack.physicsBody?.friction = 1.5
//            utrack.physicsBody?.restitution = 0.2
//            self.tracks += [utrack]
//        }

        
        var config = BalistaEngineConfiguration()
        config.forwardSpeed = 300
        config.horsepower = 50
        let engine = Engine.balista(config)
        
        let vehicle = Vehicle(position: position, chasis: chasis, engine: engine, wheels: self.wheels)
        
        self.tracks.forEach { node in
            vehicle.addChild(node)
        }
        
        
        return vehicle
    }
    
    
//    func attach(to node: SKNode) {
//        guard let attachmentBody = node.physicsBody, let scene = node.scene, tracks.count > 0, let parent = node.parent, let head = tracks.first?.physicsBody else {
//            return
//        }
//        let midx = node.frame.midX
//        let midy = node.frame.midY
//        let point = CGPoint(x: midx, y: midy)
//
//        let attachmentPoint = scene.convert(point, from: parent)
//        let joint = SKPhysicsJointPin.joint(withBodyA: attachmentBody, bodyB: head, anchor: attachmentPoint)
//        node.addChild(self)
//
//        let world = scene.physicsWorld
//        world.add(joint)
//        constructPhysics(in: world)
//    }
    
    func constructPhysics(in world: SKPhysicsWorld) {
        for index in 0..<tracks.count - 1 {
            let nodeA = tracks[index]
            let nodeB = tracks[index + 1]
            
            guard let parentA = nodeA.parent, let physicsBodyA = nodeA.physicsBody, let physicsBodyB = nodeB.physicsBody else {
                continue
            }
            
            let midx = nodeA.frame.midX
            let midy = nodeA.frame.midY
            let point = CGPoint(x: midx, y: midy)
            let attachmentPoint = targetScene.convert(point, from: parentA)
            
            let joint = SKPhysicsJointPin.joint(withBodyA: physicsBodyA, bodyB: physicsBodyB, anchor: attachmentPoint)
            joint.shouldEnableLimits = false
            joint.lowerAngleLimit = 0
            joint.upperAngleLimit = 0
            
            world.add(joint)
        }
        
        
        guard let firstTrack = tracks.first, let firstTrackParent = firstTrack.parent, let lastTrack = tracks.last else {
            return
        }
        
        let midx = firstTrack.frame.midX
        let midy = firstTrack.frame.midY
        let point = CGPoint(x: midx, y: midy)
        let attachmentPoint = targetScene.convert(point, from: firstTrackParent)
        
        let joint = SKPhysicsJointPin.joint(withBodyA: firstTrack.physicsBody!, bodyB: lastTrack.physicsBody!, anchor: attachmentPoint)
        joint.shouldEnableLimits = false
//        joint.lowerAngleLimit = 0
//        joint.upperAngleLimit = 0
//        joint.frictionTorque = 0.1
        
        world.add(joint)
    }
    
}


enum ContactCategory: UInt32 {
    case chasis = 2
    case wheel = 4
    case track = 8
    case ground = 16
    case bridge = 32
}
