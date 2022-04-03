//
//  GameScene.swift
//  ios-spritekit-physics-racing Shared
//
//  Created by Astemir Eleev on 29/07/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    // MARK: - Properties
    
    var car: Vehicle!
    
    var hudNode: SKNode!
    var cameraNode: SKCameraNode!
    
    var forwardNode: SKSpriteNode?
    var backwardNode: SKSpriteNode?
    var leftNode: SKSpriteNode?
    var rightNode: SKSpriteNode?
    
    var isContinious = false
    var isForward = false
    var isBackward = false
    var isLeft = false
    var isRight = false
    var isBreak = false
    
    var updatables: [Updatable] = []
    
    let massMax: CGFloat = .greatestFiniteMagnitude
    
    // MARK: - Methods
    
    class func newGameScene() -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .resizeFill
        
        return scene
    }
    
    func setUpScene() {
        // Get label node from scene and store it for use later
        hudNode = childNode(withName: "//HUD")
        forwardNode = childNode(withName: "//Forward") as? SKSpriteNode
        backwardNode = childNode(withName: "//Backward") as? SKSpriteNode
        cameraNode = childNode(withName: "//SKCameraNode") as? SKCameraNode
        leftNode = childNode(withName: "//Left") as? SKSpriteNode
        rightNode = childNode(withName: "//Right") as? SKSpriteNode
        
        #if os(macOS)
        // Hide the on screen controlls when the target is macOS
        hudNode.alpha = 0.0
        #endif
        
        
        self.camera = cameraNode
        
        let spawnPosition = childNode(withName: "//Spawn Position")
        
        let carFactory = VehcileAbstractFactory()
        car = try! carFactory.produce(type: .balista, at: spawnPosition?.position ?? .zero)
        /*
        let vehicleScene = SKScene(fileNamed: "BalistaVehicle")
        let builder = SKVehicleBuilder(scene: vehicleScene!, targetScene: self)
        car = builder.produce(at: spawnPosition?.position ?? .zero)
        */
        addChild(car)
        car.joints.forEach {self.physicsWorld.add($0) }
        
        /*
        builder.constructPhysics(in: physicsWorld)
        car.position = spawnPosition?.position ?? .zero
         */
         
        /*
        let softPosition01 = childNode(withName: "Soft01")?.position
        let softPosition02 = childNode(withName: "Soft02")?.position
        let softPosition03 = childNode(withName: "Soft03")?.position
        let softPosition04 = childNode(withName: "Soft04")?.position
        
        let softBall = SoftPhysicsWheel(position: softPosition01!, size: CGSize(width: 50, height: 50), color: .yellow)
        softBall.zPosition = 20
        addChild(softBall)
        updatables += [softBall]
         */
        
        // Constraint the camera to follow the car
        let zeroDistance = SKRange(constantValue: 0)
        let playerConstraint = SKConstraint.distance(zeroDistance, to: car.chasis)
        camera?.constraints = [playerConstraint]
        camera?.xScale = 1.25
        camera?.yScale = 1.25
        
        // MARK: - Test Code Starts
        
        let ropeNodeStart = childNode(withName: "Rope Node 01")
        ropeNodeStart?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 10))
        ropeNodeStart?.physicsBody?.affectedByGravity = false
        ropeNodeStart?.physicsBody?.isDynamic = false
        ropeNodeStart?.physicsBody?.mass = massMax

        let ropeNodeEnd = childNode(withName: "Rope Node 02")
        ropeNodeEnd?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 10))
        ropeNodeEnd?.physicsBody?.affectedByGravity = false
        ropeNodeEnd?.physicsBody?.isDynamic = false
        ropeNodeEnd?.physicsBody?.mass = massMax
        
        let ropeNode3 = childNode(withName: "Rope Node 03")
        ropeNode3?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 10))
        ropeNode3?.physicsBody?.affectedByGravity = false
        ropeNode3?.physicsBody?.isDynamic = false
        
        let ropeNode4 = childNode(withName: "Rope Node 04")
        ropeNode4?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 10))
        ropeNode4?.physicsBody?.affectedByGravity = false
        ropeNode4?.physicsBody?.isDynamic = false
        
        let bridgeNode = RopeNode(with: 28, and: SKTexture(imageNamed: "Ring"))
        bridgeNode.attach(to: ropeNodeStart!)
        bridgeNode.anchor(to: ropeNodeEnd!)
        
        let bridgeNode2 = RopeNode(with: 35, and: SKTexture(imageNamed: "Ring"))
        bridgeNode2.attach(to: ropeNode3!)
        bridgeNode2.anchor(to: ropeNode4!)
        
        /*
        let bridgeNode3 = RopeNode(with: 20, and: SKTexture(imageNamed: "Ring"))
        bridgeNode3.attach(to: ropeNode3!)
        
        let bridgeNode4 = RopeNode(with: 20, and: SKTexture(imageNamed: "Ring"))
        bridgeNode4.attach(to: ropeNode4!)
        */
        
        // MARK: - Test Code Ends
        
        #if os(iOS)
        if UIDevice().userInterfaceIdiom == .phone {
            camera?.xScale = 2.5
            camera?.yScale = 2.5
            
            hudNode.position.y += 50
            hudNode.xScale = 0.6
            hudNode.yScale = 0.6
        }
        #endif
        
    }
    
    #if os(watchOS)
    override func sceneDidLoad() {
        self.setUpScene()
    }
    #else
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.setUpScene()
    }
    #endif
    
    override func update(_ currentTime: TimeInterval) {
        updatables.forEach { $0.update() }
        
        // Called before each frame is rendered
        if isContinious {
            if isForward {
                car.moveForward()
            }
            if isBackward {
                car.moveBackward()
            }
            
            if isLeft {
                car.leftTilt()
            }
            
            if isRight {
                car.rightTilt()
            }
            
            if isBreak {
                car.break()
            }
        }
    }
}

#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isContinious = true
        
        for touch in touches {
            let location = touch.location(in: self)
            let toucheNodes = nodes(at: location)
            
            for touchedNode in toucheNodes {
                guard let node = touchedNode as? SKSpriteNode else {
                    continue
                }
                
                if node.name == "Forward" {
                    isForward = true
                }
                if node.name == "Backward" {
                    isBackward = true
                }
                if node.name == "Left" {
                    isLeft = true
                }
                if node.name == "Right" {
                    isRight = true
                }
                if node.name == "Break" {
                    isBreak = true
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Empty implementation */
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isContinious = false
        
        for touch in touches {
            let location = touch.location(in: self)
            let toucheNodes = nodes(at: location)
            
            for touchedNode in toucheNodes {
                guard let node = touchedNode as? SKSpriteNode else {
                    continue
                }
                
                if node.name == "Forward" {
                    isForward = false
                }
                if node.name == "Backward" {
                    isBackward = false
                }
                if node.name == "Left" {
                    isLeft = false
                }
                if node.name == "Right" {
                    isRight = false
                }
                if node.name == "Break" {
                    isBreak = false
                }
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        isContinious = false
        
        for touch in touches {
            let location = touch.location(in: self)
            let toucheNodes = nodes(at: location)
            
            for touchedNode in toucheNodes {
                guard let node = touchedNode as? SKSpriteNode else {
                    continue
                }
                
                if node.name == "Forward" {
                    isForward = false
                }
                if node.name == "Backward"{
                    isBackward = false
                }
                if node.name == "Left" {
                    isLeft = false
                }
                if node.name == "Right" {
                    isRight = false
                }
                if node.name == "Break" {
                    isBreak = false
                }
            }
        }
    }
    
   
}
#endif

#if os(OSX)

import Carbon

// Mouse-based event handling
extension GameScene {

    // MARK: - Properties
    
    static let downArrow = UInt16(kVK_DownArrow)
    static let leftArrow = UInt16(kVK_LeftArrow)
    static let rightArrow = UInt16(kVK_RightArrow)
    static let upArrow = UInt16(kVK_UpArrow)
    static let backSpace = UInt16(kVK_Space)
    
    // MARK: - Mouse handling
    
    override func mouseDown(with event: NSEvent) {
    }
    
    override func mouseDragged(with event: NSEvent) {
    }
    
    override func mouseUp(with event: NSEvent) {
    }
    
    // MARK: - Keyboard handling
    
    override func keyUp(with event: NSEvent) {
        isContinious = false
        
        let keyCode = event.keyCode
        
        if keyCode == GameScene.leftArrow {
            isBackward = false
        }
        
        if keyCode == GameScene.rightArrow {
            isForward = false
        }
        
        if keyCode == GameScene.upArrow {
            isLeft = false
        }
        
        if keyCode == GameScene.downArrow {
            isRight = false
        }
        
        if keyCode == GameScene.backSpace {
            isBreak = false
        }
    }

    override func keyDown(with event: NSEvent) {
        isContinious = true
        
        let keyCode = event.keyCode
        
        if keyCode == GameScene.leftArrow {
            isBackward = true
        }
        
        if keyCode == GameScene.rightArrow {
            isForward = true
        }
        
        if keyCode == GameScene.upArrow {
            isLeft = true
        }
        
        if keyCode == GameScene.downArrow {
            isRight = true
        }
        
        if keyCode == GameScene.backSpace {
            isBreak = true
        }
    }

}
#endif

