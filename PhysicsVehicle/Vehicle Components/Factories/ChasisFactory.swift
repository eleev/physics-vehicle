//
//  ChasisFactory.swift
//  ios-spritekit-physics-racing iOS
//
//  Created by Astemir Eleev on 15/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct ChasisFactory {

    /// Producces a `ChasisNode` that is the foundamental part of a vehicle based on a vechicle type
    ///
    /// - Parameters:
    ///     - type: is a `VehicleType` enum that specifies which type of chasis do you want to produce
    ///     - position: is a `CGPoint` type that specifies the physical position of a `ChasisNode`
    func produce(of type: VehicleType, at position: CGPoint) -> ChasisNode {
        var builder: ChasisBuilder!
        
        switch type {
        case .jeep:
            builder = JeepChasisBuilder(position: position)
        case .humvee:
            builder = HumveeChasisBuilder(position: position)
        case .schoolBus:
            builder = SchoolBusChasisBuilder(position: position)
        case .balista:
            builder = BalistaChasisBuilder(position: position)
        }
        return ChasisNode(builder: builder)
    }
}
