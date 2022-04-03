//
//  JeepEngineBuilder.swift
//  ios-spritekit-physics-racing iOS
//
//  Created by Astemir Eleev on 18/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import CoreGraphics

struct JeepStandardEngineConfiguration: EngineConfiguration {
    var horsepower: Int = 35
    var forwardSpeed: CGFloat = 750
    var backwardSpeed: CGFloat = -450
}

struct JeepPoweredEngineConfiguration: EngineConfiguration {
    var horsepower: Int = 105
    var forwardSpeed: CGFloat = 1250
    var backwardSpeed: CGFloat = -750
}
