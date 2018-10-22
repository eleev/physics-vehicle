//
//  Wheel.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 14/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct PhysicsWheel {
    
    // MARK: - Properties
    
    private(set) var sprite: WheelNode
    private(set) var suspension: WheelSuspension
    private(set) var isBreakable: Bool
    
    // MARK: - Initializers
    
    init(node: WheelNode, suspension: WheelSuspension, isBreakable: Bool = true) {
        self.sprite = node
        self.suspension = suspension
        self.isBreakable = isBreakable
    }
}
