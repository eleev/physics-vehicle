//
//  VehicleAbstractFactory.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 14/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct VehcileAbstractFactory {
    
    // MARK: - Properties
    
    private let chasisFactory = ChasisFactory()
    private let suspensionFactory = SuspentionFactory()
    private let wheelFactory = WheelFactory()
    
    // MARK: - Methods
    
    func propduce(type: VehicleType, at position: CGPoint) -> Vehicle {
        let chasis = chasisFactory.produce(of: type, at: position)
        let leftWheel = produce(type: type,
                at: position,
                using: chasis,
                shockPostOffset: <#T##CGPoint#>,
                shockPostPosition: <#T##CGPoint#>,
                springAttachmentPoint: <#T##CGPoint#>)
        
        let rightWheel = produce(type: type,
                                 at: position,
                                 using: chasis,
                                 shockPostOffset: <#T##CGPoint#>,
                                 shockPostPosition: <#T##CGPoint#>,
                                 springAttachmentPoint: <#T##CGPoint#>)
        
        let vehicle = Vehicle(position: position, chasis: chasis, wheels: [leftWheel, rightWheel])
        return vehicle
    }
    
    private func produce(type: VehicleType, at position: CGPoint, using chasis: ChasisNode, shockPostOffset: CGPoint, shockPostPosition: CGPoint, springAttachmentPoint: CGPoint) -> PhysicsWheel {
        
        let wheelNode = wheelFactory.produce(of: type, at: position)
        let suspension = suspensionFactory.produce(of: type,
                                                   wheelNode: wheelNode,
                                                   chasis: chasis,
                                                   shockPostOffset: shockPostOffset,
                                                   shockPostPosiiton: shockPostPosition,
                                                   springAttachmentPoint: springAttachmentPoint)
        let physicsWheel = wheelFactory.produce(with: wheelNode, using: suspension)
        return physicsWheel
    }
    
}
