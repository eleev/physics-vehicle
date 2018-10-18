//
//  JeepChasisBuilder.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 15/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct JeepChasisBuilder: ChasisBuilder {
    
    // MARK: - Properties
    
    var texture: SKTexture {        
        let assetName = "car-body"
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
    
    var size: CGSize        = CGSize(width: 400, height: 112.3)
    var zPosition: CGFloat  = 8
    var density: CGFloat    = 2

    // MARK: - Initializers
    
    init(position: CGPoint) {
        self.position = position
    }
}
