//
//  HumveeWheelSuspensionBuilder.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 17/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct HumveeWheelSuspensionBuilder: WheelSuspensionBuilder {
    
    // MARK: - Properties
    
    var dapming: CGFloat                = 0.5
    var frequiency: CGFloat             = 6
    var wheelOffset: CGPoint            = CGPoint(x: 0, y: 95)
    var shockPostColor: SKColor         = .clear
    var shockPostSize: CGSize           = CGSize(width: 7, height: 95)
    var slideLoweLimit: CGFloat         = 5
    
    var shockPostPosition: CGPoint
    var springAttachmentPoint: CGPoint
    
    // MRAK: - Initializers
    
    init(shockPostPosition: CGPoint, springAttachmentPoint: CGPoint) {
        self.shockPostPosition = shockPostPosition
        self.springAttachmentPoint = springAttachmentPoint
    }
}
