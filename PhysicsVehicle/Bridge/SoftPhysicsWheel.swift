//
//  SoftPhysicsWheel.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 24/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

protocol Updatable: AnyObject {
    func update()
}

class SoftPhysicsWheel: SKNode, Updatable {
    
    // MARK: - Properties
    
    private(set) var ballLine: SKShapeNode!
    private(set) var circles = [SKShapeNode]()
    
    let radius: CGFloat = 30
    let outerCircleRadius: CGFloat = 15
    let dynamic = true
    let jointDamping: CGFloat = 1.0
    let jointFrequency: CGFloat = 9.0
    let numOfCircles = 22
    let massOfCenterCircle: CGFloat = 8.0
    let massOfOuterCircles: CGFloat = 2.0
    let ballGlowWidth: CGFloat = 5.0
    
    let size: CGSize
    private(set) var basePhysicsBody: SKPhysicsBody?
    
    // MARK: - Initialiezers
    
    init(position: CGPoint, size: CGSize, color: SKColor) {
        self.size = size

        super.init()
        self.position = position
        
        makeCircles()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func makeCircles() {
        //Main circle
        let circleShape = SKShapeNode(circleOfRadius: radius)
        circleShape.fillColor = SKColor.orange
        circleShape.strokeColor = SKColor.black
        circleShape.lineWidth = 2.0
        circleShape.position = position

        
        let circlePhysics = SKPhysicsBody(circleOfRadius: radius)
        circlePhysics.isDynamic = dynamic
        circlePhysics.mass = massOfCenterCircle
        circlePhysics.affectedByGravity = false
        basePhysicsBody = circlePhysics

        
        circleShape.physicsBody = circlePhysics
        addChild(circleShape)
        circles.append(circleShape)
        
        //Outer circle
        for i in 0..<numOfCircles {
            let massOfOuterCircle = massOfOuterCircles / CGFloat(numOfCircles)
            
            let angle = (Double.pi * 2 / Double(numOfCircles)) * Double(i)
            let dy = CGFloat(sin(angle)) * radius
            let dx = CGFloat(cos(angle)) * radius
            
            let point = SKShapeNode(circleOfRadius: outerCircleRadius)
            point.position = CGPoint(x: circles.first!.position.x + dx * 2, y: circles.first!.position.y + dy * 2)
            point.fillColor = SKColor.clear
            point.strokeColor = SKColor.clear
            point.physicsBody = SKPhysicsBody(circleOfRadius: point.frame.size.width / 2)
            point.physicsBody!.mass = massOfOuterCircle
            point.physicsBody!.isDynamic = dynamic
            addChild(point)
            circles.append(point)
            
            
            makeJointBetween(point: circles.first!, point2: point)
            
            
        }
        
        for i in 1..<circles.count {
            if i == 1 {
                makeJointBetween(point: circles.last!, point2: circles[1])
                
            }else{
                makeJointBetween(point: circles[i], point2: circles[i - 1])
                
            }
        }
    }
    
    private func makeJointBetween(point: SKShapeNode, point2: SKShapeNode) {
//        
        let joint = SKPhysicsJointSpring.joint(withBodyA: point.physicsBody!, bodyB: point2.physicsBody!, anchorA: point.position, anchorB: point2.position)
        joint.damping = jointDamping
        joint.frequency = jointFrequency
        scene?.physicsWorld.add(joint)
    }
    
    
    private func drawBallLine() {
        if ballLine != nil{
            ballLine.removeFromParent()
        }
        
        ballLine = SKShapeNode()
        var point = circles.first!
        
        
        #if os(iOS)
        typealias BezierPath = UIBezierPath
        #elseif os(macOS)
        typealias BezierPath = NSBezierPath
        #endif
        let path = BezierPath()
        path.move(to: point.position)
        
        #if os(iOS)
        for i in 0..<circles.count {
            point = circles[i]
            
            path.addLine(to: point.position)
            
            
            if i == circles.count - 1{
                path.addLine(to: circles[1].position)
            }
        }
        #elseif os(macOS)
        for i in 0..<circles.count {
            point = circles[i]
            
            path.line(to: point.position)
            
            if i == circles.count - 1 {
                path.line(to: circles[1].position)
            }
        }
        #endif
        ballLine.path = path.cgPath
        
        
        ballLine.glowWidth = ballGlowWidth
        ballLine.fillColor = SKColor.orange
        ballLine.strokeColor = SKColor.orange
        addChild(ballLine)
    }
    
    func update() {
        drawBallLine()
    }
}

#if os(macOS)
extension NSBezierPath {
    
    public var cgPath: CGPath {
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)
        
        for i in 0 ..< self.elementCount {
            let type = self.element(at: i, associatedPoints: &points)
            switch type {
            case .moveTo:
                path.move(to: points[0])
            case .lineTo:
                path.addLine(to: points[0])
            case .curveTo:
                path.addCurve(to: points[2], control1: points[0], control2: points[1])
            case .closePath:
                path.closeSubpath()
            @unknown default:
                fatalError("Unsupported NSBezierPath case")
            }
        }
        
        return path
    }
}
#endif
