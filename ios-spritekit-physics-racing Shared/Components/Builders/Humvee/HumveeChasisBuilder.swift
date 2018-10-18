//
//  HumveeChasisBuilder.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 17/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct HumveeChasisBuilder: ChasisBuilder {
    
    // MARK: - Properties
    
    var texture: SKTexture {
        let assetName = "humvee-body"
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
    
    var size: CGSize        = CGSize(width: 400, height: 197.43)
    var zPosition: CGFloat  = 8
    var density: CGFloat    = 2.0

    // MARK: - Initializers
    
    init(position: CGPoint) {
        self.position = position
    }
}
