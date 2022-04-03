//
//  BalistaWheelBuilder.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 19/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct BalistaWheelBuilder: WheelBuilder {
    
    // MARK: - Properties
    
    var texture: SKTexture {
        
        let assetName = "balista-wheel"
        var texture: SKTexture!
        
        #if os(macOS)
        guard let image = NSImage(named: assetName) else {
            fatalError("Could not load NSImage for JeepWheelBuilder")
        }
        
        texture = SKTexture(image: image)
        #endif
        
        #if os(iOS)
        guard let image = UIImage(named: assetName) else {
            fatalError("Could not load NSImage for JeepWheelBuilder")
        }
        texture = SKTexture(image: image)
        #endif
        
        return texture
    }
    var position: CGPoint
    
    var size: CGSize            = CGSize(width: 100, height: 100)
    var zPostiion: CGFloat      = 10
    var allowsRotation: Bool    = true
    var friction: CGFloat       = 1.0
    var restitution: CGFloat    = 0.3
    
    // MARK: - Initializers
    
    init(position: CGPoint) {
        self.position = position
    }
}
