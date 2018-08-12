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
    
    var car: VehicleProtocol!
    
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
        
        car = VehicleJeep(position: spawnPosition?.position ?? .zero)
//        car = VehicleHumvee(position: spawnPosition?.position ?? .zero)
        addChild(car as! SKNode)
        
        car.joints.forEach { joint in
            self.physicsWorld.add(joint)
        }
        
        
        // Constraint the camera to follow the car
        let zeroDistance = SKRange(constantValue: 0)
        let playerConstraint = SKConstraint.distance(zeroDistance, to: car.chasis)
        camera?.constraints = [playerConstraint]
        camera?.xScale = 1.0
        camera?.yScale = 1.0
        
    }
    
    #if os(watchOS)
    override func sceneDidLoad() {
        self.setUpScene()
    }
    #else
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    #endif
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if isContinious {
            if isForward {
                car.applyForwardImpulse()
            }
            if isBackward {
                car.applyBackwardImpulse()
            }
            
            if isLeft {
                car.applyLeftTilt()
            }
            
            if isRight {
                car.applyRightTilt()
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
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
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
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
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
    }

}
#endif

