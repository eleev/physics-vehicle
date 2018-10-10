//
//  WheelVehicleComponentsFactory.swift
//  ios-spritekit-physics-racing iOS
//
//  Created by Astemir Eleev on 10/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct WheelVehicleComponentsFactory {
    
    /// Produces a vechicle wheel with physics-based suspention
    ///
    /// - Parameters:
    ///     - builder: is a WheelBuilder that holds all the configuration for a wheel
    /// - Returns: a SKSpriteNode that represents a vehicle wheel and can be fither used as a component
    func produce(using builder: WheelBuilder) -> SKSpriteNode {
        fatalError(#function + " has not been implemented")
        return SKSpriteNode(color: .clear, size: .zero)
    }
}
