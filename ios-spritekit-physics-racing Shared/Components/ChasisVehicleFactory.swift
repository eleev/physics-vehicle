//
//  ChasisVehicleFactory.swift
//  ios-spritekit-physics-racing iOS
//
//  Created by Astemir Eleev on 10/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct ChasisVehicleFactory {
    
    /// Constructs a physics-based chasis of a vechicle
    ///
    /// - Parameters:
    ///     - builder: is a ChasisBuilder that holds all the chasis configuration
    /// - Returns: a SKSpriteNode component that represents a vehicle's chasis and can be futher used as a vehicle's component
    func produce(using builder: ChasisBuidler) -> SKSpriteNode {
        fatalError(#function + " has not been implemented yet")
        return SKSpriteNode(color: .clear, size: .zero)
    }
}
