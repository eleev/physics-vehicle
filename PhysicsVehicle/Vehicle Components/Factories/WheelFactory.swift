//
//  WheelFactory.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 15/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct WheelFactory {
    
    func produce(of type: VehicleType, at position: CGPoint) -> WheelNode {
        var builder: WheelBuilder
        
        switch type {
        case .jeep:
            builder = JeepWheelBuilder(position: position)
        case .humvee:
            builder = HumveeWheelBuilder(position: position)
        case .schoolBus:
            builder = SchoolBusWheelBuilder(position: position)
        case .balista:
            builder = BalistaWheelBuilder(position: position)
        }
        return WheelNode(builder: builder)
    }
    
    func produce(with node: WheelNode, using suspension: WheelSuspension, isBreakable: Bool) -> PhysicsWheel {
        return PhysicsWheel(node: node, suspension: suspension, isBreakable: isBreakable)
    }
}
