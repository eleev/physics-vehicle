//
//  ChasisNode.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 14/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

class ChasisNode: SKSpriteNode {
    
    // MARK: - Initializers
    
    init(builder: ChasisBuilder) {
        super.init(texture: builder.texture, color: .clear, size: builder.size)
        
        position = builder.position
        zPosition = builder.zPosition
        physicsBody = SKPhysicsBody(texture: builder.texture, alphaThreshold: 0.0, size: size)
        physicsBody?.density = builder.density
    }
    
    init(node: SKSpriteNode) {
        super.init(texture: node.texture, color: .clear, size: node.size)
        
        position = node.position
        zPosition = node.zPosition
        physicsBody = node.physicsBody
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
