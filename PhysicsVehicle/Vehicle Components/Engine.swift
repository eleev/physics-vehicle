//
//  Engine.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 17/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import Foundation
import CoreGraphics

enum Engine {
    case jeepStandard(EngineConfiguration)
    case jeepPowered(EngineConfiguration)
    case humvee(EngineConfiguration)
    case schoolBus(EngineConfiguration)
    case balista(EngineConfiguration)
}

extension Engine {

    func forwardPower() -> Int {
        switch self {
        case .humvee(let configuration),
             .jeepPowered(let configuration),
             .jeepStandard(let configuration),
             .schoolBus(let configuration),
             .balista(let configuration):
            return configuration.horsepower
        }
    }
    
    func backwardPower() -> Int {
        switch self {
        case .humvee(let configuration),
             .jeepPowered(let configuration),
             .jeepStandard(let configuration),
             .schoolBus(let configuration),
             .balista(let configuration):
            return -(configuration.horsepower / 3)
        }
    }
    
    func forwardSpeed() -> CGFloat {
        switch self {
        case .humvee(let configuration),
             .jeepPowered(let configuration),
             .jeepStandard(let configuration),
             .schoolBus(let configuration),
             .balista(let configuration):
            return configuration.forwardSpeed
        }
    }
    
    func backwardSpeed() -> CGFloat {
        switch self {
        case .humvee(let configuration),
             .jeepPowered(let configuration),
             .jeepStandard(let configuration),
             .schoolBus(let configuration),
             .balista(let configuration):
            return configuration.backwardSpeed
        }
    }
}
