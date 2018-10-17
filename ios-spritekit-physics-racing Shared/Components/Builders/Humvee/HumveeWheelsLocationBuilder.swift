//
//  HumveeWheelsLocationBuilder.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 17/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import Foundation

struct HumveeWheelsLocationBuilder: WheelsLocationBuilder {
    
    // MARK: - Properties
    
    var locations: [WheelLocation]
    
    // MARK: - Initializers
    
    init(chasis: ChasisNode) {
        locations = []
        locations.reserveCapacity(2)
        
        let chasisHalfX = chasis.size.width / 2
        let chasisLeftHalfX = chasis.position.x - chasisHalfX
        let chasisRightHalfX = chasis.position.x + chasisHalfX
        
        let leftWheelPosition = CGPoint(x: chasisLeftHalfX + 58, y: chasis.position.y - 95)
        let rightWheelPosition = CGPoint(x: chasisRightHalfX - 72, y: chasis.position.y - 95)
        
        let chasisShockY = chasis.position.y - (95 / 2)
        
        
        let leftWheel = WheelLocation.init(wheelLocation: leftWheelPosition,
                                           shockPostLocation: CGPoint(x: leftWheelPosition.x + 10, y: chasisShockY),
                                           springAttachmentLocation: CGPoint(x: leftWheelPosition.x + 10, y: chasis.position.y))
        
        let rightWheel = WheelLocation.init(wheelLocation: rightWheelPosition,
                                            shockPostLocation: CGPoint(x: rightWheelPosition.x + 10, y: chasisShockY),
                                            springAttachmentLocation: CGPoint(x: rightWheelPosition.x + 10, y: chasis.position.y))
        locations += [leftWheel, rightWheel]
    }
}
