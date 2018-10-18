//
//  SchoolBusChasisBuilder.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 18/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct SchoolBusChasisBuilder: ChasisBuilder {
    
    // MARK: - Properties
    
    var texture: SKTexture {
        let assetName = "school-bus-carcass"
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
    
    var size: CGSize        = CGSize(width: 600, height: 166.666)
    var zPosition: CGFloat  = 8
    var density: CGFloat    = 1.3
    
    // MARK: - Initializers
    
    init(position: CGPoint) {
        self.position = position
    }
}
