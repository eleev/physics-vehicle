//
//  JeepWheelSuspensionBuilder.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 15/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct JeepWheelSuspensionBuilder: WheelSuspensionBuilder {

    // MARK: - Properties
    
    var dapming: CGFloat                = 0.5
    var frequiency: CGFloat             = 4.5
    var wheelOffset: CGPoint            = CGPoint(x: 0, y: 65)
    var shockPostColor: SKColor         = .clear
    var shockPostSize: CGSize           = CGSize(width: 12, height: 65)
    var slideLoweLimit: CGFloat         = 0.1
    
    var shockPostPosition: CGPoint
    var springAttachmentPoint: CGPoint
    
    // MRAK: - Initializers
    
    init(shockPostPosition: CGPoint, springAttachmentPoint: CGPoint) {
        self.shockPostPosition = shockPostPosition
        self.springAttachmentPoint = springAttachmentPoint
    }
}
