//
//  SchoolBusWheelSuspensionBuilder.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 18/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct SchoolBusWheelSuspensionBuilder: WheelSuspensionBuilder {
    
    // MARK: - Properties
    
    var dapming: CGFloat                = 0.8
    var frequiency: CGFloat             = 8
    var wheelOffset: CGPoint            = CGPoint(x: 0, y: 100)
    var shockPostColor: SKColor         = .clear
    var shockPostSize: CGSize           = CGSize(width: 40, height: 40)
    var slideLoweLimit: CGFloat         = 1
    
    var shockPostPosition: CGPoint
    var springAttachmentPoint: CGPoint
    
    // MRAK: - Initializers
    
    init(shockPostPosition: CGPoint, springAttachmentPoint: CGPoint) {
        self.shockPostPosition = shockPostPosition
        self.springAttachmentPoint = springAttachmentPoint
    }
}
