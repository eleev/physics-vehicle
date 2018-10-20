//
//  ChainNode.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 19/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

class ChainNode: SKSpriteNode {
    
    // MARK: - Initializers
    
    init(nodeTexture: SKTexture) {
        super.init(texture: nodeTexture, color: .clear, size: nodeTexture.size())
        self.zRotation = CGFloat.pi / 2
        setupPhysics()
    }
    
    init(color: SKColor, size: CGSize = .init(width: 50, height: 20)) {
        super.init(texture: nil, color: color, size: size)
        setupPhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupPhysics() {
        anchorPoint = CGPoint(x: 0.5, y: 1.0)
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.usesPreciseCollisionDetection = true
    }
}
