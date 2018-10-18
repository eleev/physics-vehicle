//
//  ChasisBuilder.swift
//  ios-spritekit-physics-racing iOS
//
//  Created by Astemir Eleev on 14/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

protocol ChasisBuilder {
    var texture: SKTexture { get }
    var size: CGSize { get }
    var zPosition: CGFloat { get }
    var position: CGPoint { get }
    
    var density: CGFloat { get }
}

