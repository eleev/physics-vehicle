//
//  BalistaWheelSuspensionBuilder.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 19/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct BalistaWheelSuspensionBuilder: WheelSuspensionBuilder {
    
    // MARK: - Properties
    
    var dapming: CGFloat                = 0.5
    var frequiency: CGFloat             = 3
    var wheelOffset: CGPoint            = CGPoint(x: 0, y: 100)
    var shockPostColor: SKColor         = .clear
    var shockPostSize: CGSize           = CGSize(width: 40, height: 70)
    var slideLoweLimit: CGFloat         = 10
    
    var shockPostPosition: CGPoint
    var springAttachmentPoint: CGPoint
    
    // MRAK: - Initializers
    
    init(shockPostPosition: CGPoint, springAttachmentPoint: CGPoint) {
        self.shockPostPosition = shockPostPosition
        self.springAttachmentPoint = springAttachmentPoint
    }
}
