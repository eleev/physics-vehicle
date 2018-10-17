//
//  Engine.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 17/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import Foundation

enum Engine: Int {
    case jeepStandard = 15
    case jeepPowered = 25
    case humvee = 19
}

extension Engine {
    
    func forwardPower() -> Int {
        return self.rawValue
    }
    
    func backwardPower() -> Int {
        return -(self.rawValue / 3)
    }
}
