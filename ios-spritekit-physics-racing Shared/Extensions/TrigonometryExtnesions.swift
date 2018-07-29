//
//  TrigonometryExtnesions.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 29/07/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import Foundation
import CoreGraphics

extension BinaryInteger {
    var degreesToRadians: CGFloat { return CGFloat(Int(self)) * .pi / 180 }
}

extension FloatingPoint {
    var toRadians: Self { return self * .pi / 180 }
    var toDegrees: Self { return self * 180 / .pi }
}
