//
//  BalistaWheelsLocationBuilder.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 19/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import CoreGraphics

struct BalistaWheelsLocationBuilder: WheelsLocationBuilder {
    
    // MARK: - Properties
    
    var locations: [WheelLocation]
    
    // MARK: - Initializers
    
    init(chasis: ChasisNode) {
        locations = []
        locations.reserveCapacity(2)
        
        let chasisHalfX = chasis.size.width / 2
        let chasisLeftHalfX = chasis.position.x - chasisHalfX
        let chasisRightHalfX = chasis.position.x + chasisHalfX
        
        let leftWheelPosition = CGPoint(x: chasisLeftHalfX + 40, y: chasis.position.y - 160)
        let leftMidWheelPosition = CGPoint(x: chasisLeftHalfX + 160, y: chasis.position.y - 160)
        let midWheelPosition = CGPoint(x: chasis.position.x - 10, y: chasis.position.y - 160)
        let rightMidWheelPosition = CGPoint(x: chasisRightHalfX - 180, y: chasis.position.y - 160)
        let rightWheelPosition = CGPoint(x: chasisRightHalfX - 60, y: chasis.position.y - 160)
        
        
        let chasisShockY = chasis.position.y - 120
        
        
        let leftWheel = WheelLocation.init(wheelLocation: leftWheelPosition,
                                           shockPostLocation:
            CGPoint(x: leftWheelPosition.x, y: chasisShockY),
                                           springAttachmentLocation:
            CGPoint(x: leftWheelPosition.x, y: chasis.position.y))
        
        let leftMidWheel = WheelLocation.init(wheelLocation: leftMidWheelPosition,
                                           shockPostLocation:
            CGPoint(x: leftMidWheelPosition.x, y: chasisShockY),
                                           springAttachmentLocation:
            CGPoint(x: leftMidWheelPosition.x, y: chasis.position.y))
        
        let midWheel = WheelLocation.init(wheelLocation: midWheelPosition,
                                           shockPostLocation:
            CGPoint(x: midWheelPosition.x, y: chasisShockY),
                                           springAttachmentLocation:
            CGPoint(x: midWheelPosition.x, y: chasis.position.y), isBreakable: false)
        
        let rightWheel = WheelLocation.init(wheelLocation: rightWheelPosition,
                                            shockPostLocation:
            CGPoint(x: rightWheelPosition.x , y: chasisShockY),
                                            springAttachmentLocation:
            CGPoint(x: rightWheelPosition.x, y: chasis.position.y), isBreakable: false)
        
        let rightMidWheel = WheelLocation.init(wheelLocation: rightMidWheelPosition,
                                            shockPostLocation:
            CGPoint(x: rightMidWheelPosition.x , y: chasisShockY),
                                            springAttachmentLocation:
            CGPoint(x: rightMidWheelPosition.x, y: chasis.position.y), isBreakable: false)
        
        locations += [leftWheel, leftMidWheel, midWheel, rightMidWheel, rightWheel]
    }
}
