//
//  SchoolBusWheelsLocationBuilder.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 18/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import CoreGraphics

struct SchoolBusWheelsLocationBuilder: WheelsLocationBuilder {
    
    // MARK: - Properties
    
    var locations: [WheelLocation]
    
    // MARK: - Initializers
    
    init(chasis: ChasisNode) {
        locations = []
        locations.reserveCapacity(2)
        
        let chasisHalfX = chasis.size.width / 2
        let chasisLeftHalfX = chasis.position.x - chasisHalfX
        let chasisRightHalfX = chasis.position.x + chasisHalfX
        
        let leftWheelPosition = CGPoint(x: chasisLeftHalfX + 185, y: chasis.position.y - 55)
        let rightWheelPosition = CGPoint(x: chasisRightHalfX - 58, y: chasis.position.y - 51)
        
        let chasisShockY = chasis.position.y - 10
        
        
        let leftWheel = WheelLocation.init(wheelLocation: leftWheelPosition,
                                           shockPostLocation: CGPoint(x: leftWheelPosition.x, y: chasisShockY),
                                           springAttachmentLocation: CGPoint(x: leftWheelPosition.x, y: chasis.position.y))
        
        let rightWheel = WheelLocation.init(wheelLocation: rightWheelPosition,
                                            shockPostLocation: CGPoint(x: rightWheelPosition.x , y: chasisShockY),
                                            springAttachmentLocation: CGPoint(x: rightWheelPosition.x, y: chasis.position.y))
        locations += [leftWheel, rightWheel]
    }
}
