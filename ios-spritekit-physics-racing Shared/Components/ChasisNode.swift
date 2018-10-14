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
        self.position = builder.position
        self.zPosition = builder.zPosition
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
