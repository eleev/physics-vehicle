//
//  BalistaChasisBuilder.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 19/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct BalistaChasisBuilder: ChasisBuilder {
    
    // MARK: - Properties
    
    var texture: SKTexture {
        let assetName = "balista-chasis"
        var texture: SKTexture!
        
        #if os(macOS)
        texture = SKTexture(image: NSImage(named: assetName)!)
        #endif
        
        #if os(iOS)
        texture = SKTexture(image: UIImage(named: assetName)!)
        #endif
        
        return texture
    }
    var position: CGPoint
    
    var size: CGSize = .init(width: 600, height: 317.72)
    var zPosition: CGFloat  = 8
    var density: CGFloat    = 1.2
    
    // MARK: - Initializers
    
    init(position: CGPoint) {
        self.position = position
    }
}

