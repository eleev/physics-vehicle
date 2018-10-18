//
//  EngineConfiguration.swift
//  ios-spritekit-physics-racing iOS
//
//  Created by Astemir Eleev on 18/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import Foundation
import CoreGraphics

protocol EngineConfiguration {
    var horsepower: Int { get }
    var forwardSpeed: CGFloat { get }
    var backwardSpeed: CGFloat { get }
}
