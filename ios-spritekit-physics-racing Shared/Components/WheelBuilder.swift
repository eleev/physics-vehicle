//
//  WheelBuilder.swift
//  ios-spritekit-physics-racing iOS
//
//  Created by Astemir Eleev on 10/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

protocol WheelSuspensionBuilder {
    var dapming: CGFloat { get }
    var frequiency: CGFloat { get }
    var shockPostColor: SKColor { get }
    var shockPostSize: CGSize { get }
    var shockPostOffset: CGPoint { get }
    var shockPostPosition: CGPoint { get }
}

protocol WheelBuilder {
    var texture: SKTexture { get }
    var size: CGSize { get }
    var zPostiion: CGFloat { get }
    var position: CGPoint { get }
    var allowsRotation: Bool { get }
    var offset: CGPoint { get }
    
}
