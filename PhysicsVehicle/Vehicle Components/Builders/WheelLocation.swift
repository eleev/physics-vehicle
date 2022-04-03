//
//  WheelLocation.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 17/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct WheelLocation {
    
    // MARK: - Properties
    
    private(set) var wheelLocation: CGPoint
    private(set) var shockPostLocation: CGPoint
    private(set) var springAttachmentLocation: CGPoint
    
    /// Breakable wheel means that it can be used to physically stop the Vehicle
    private(set) var isBreakable: Bool
    
    // MARK: - Initializers
    
    init(wheelLocation: CGPoint, shockPostLocation: CGPoint, springAttachmentLocation: CGPoint, isBreakable: Bool = true) {
        self.wheelLocation = wheelLocation
        self.shockPostLocation = shockPostLocation
        self.springAttachmentLocation = springAttachmentLocation
        self.isBreakable = isBreakable
    }
}
