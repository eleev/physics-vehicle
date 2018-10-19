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
    
    var dapming: CGFloat                = 0.75
    var frequiency: CGFloat             = 5
    var wheelOffset: CGPoint            = CGPoint(x: 0, y: 65)
    var shockPostColor: SKColor         = .clear
    var shockPostSize: CGSize           = CGSize(width: 7, height: 65)
    var slideLoweLimit: CGFloat         = 4
    
    var shockPostPosition: CGPoint
    var springAttachmentPoint: CGPoint
    
    // MRAK: - Initializers
    
    init(shockPostPosition: CGPoint, springAttachmentPoint: CGPoint) {
        self.shockPostPosition = shockPostPosition
        self.springAttachmentPoint = springAttachmentPoint
    }
}
