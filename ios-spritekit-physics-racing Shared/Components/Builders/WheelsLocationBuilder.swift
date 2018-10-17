//
//  WheelsLocationBuilder.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 17/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import Foundation

protocol WheelsLocationBuilder {
    var locations: [WheelLocation] { get }
    init(chasis: ChasisNode)
}
