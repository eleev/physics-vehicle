//
//  WheelSuspensionBuilder.swift
//  ios-spritekit-physics-racing iOS
//
//  Created by Astemir Eleev on 15/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

protocol WheelSuspensionBuilder {
    var dapming: CGFloat { get }
    var frequiency: CGFloat { get }
    var wheelOffset: CGPoint { get }
    var shockPostColor: SKColor { get }
    var shockPostSize: CGSize { get }
    var shockPostPosition: CGPoint { get }
    var slideLoweLimit: CGFloat { get }
    var springAttachmentPoint: CGPoint { get }
}
