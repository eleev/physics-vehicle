//
//  VehicleAbstractFactory.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 14/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct ChasisFactory {
    
    func produce() -> ChasisNode {
        fatalError()
    }
}

struct SuspentionFactory {
    
    func produce() -> WheelSuspension {
        fatalError()
    }
}

struct WheelFactory {
    
    func produce() -> Wheel {
        fatalError()
    }
}

struct VehcileAbstractFactory {
    
    // MARK: - Properties
    
    private let chasisFactory = ChasisFactory()
    private let suspensionFactory = SuspentionFactory()
    private let wheelFactory = WheelFactory()
    
    // MARK: - Methods
    
    func propduce(type: VehicleType) -> Vehicle {
        fatalError()
    }
}
