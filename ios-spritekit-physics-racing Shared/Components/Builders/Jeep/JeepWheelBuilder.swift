//
//  JeepWheelBuilder.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 15/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct JeepWheelBuilder: WheelBuilder {
    
    // MARK: - Properties
    
    var texture: SKTexture {
        let assetName = "car-wheel"
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
    
    var size: CGSize            = CGSize(width: 78, height: 78)
    var zPostiion: CGFloat      = 10
    var allowsRotation: Bool    = true
    var offset: CGPoint         = CGPoint(x: 68, y: 65)
    
    // MARK: - Initializers
    
    init(position: CGPoint) {
        self.position = position
    }
}
