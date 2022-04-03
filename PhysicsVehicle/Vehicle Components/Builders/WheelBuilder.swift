//
//  WheelBuilder.swift
//  ios-spritekit-physics-racing iOS
//
//  Created by Astemir Eleev on 10/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

protocol WheelBuilder {
    
    // MARK: - Properties
    
    var texture: SKTexture { get }
    var size: CGSize { get }
    var zPostiion: CGFloat { get }
    var position: CGPoint { get }
    
    // MARK: - Physics properties
    
    var allowsRotation: Bool { get }
    var friction: CGFloat { get }
    var restitution: CGFloat { get }
}
