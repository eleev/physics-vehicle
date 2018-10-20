//
//  SuspentionFactory.swift
//  ios-spritekit-physics-racing iOS
//
//  Created by Astemir Eleev on 15/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct SuspentionFactory {
    
    func produce(of type: VehicleType, wheelNode: WheelNode, chasis: ChasisNode, shockPostPosiiton: CGPoint, springAttachmentPoint: CGPoint) -> WheelSuspension? {
        var builder: WheelSuspensionBuilder
        
        switch type {
        case .jeep:
            builder = JeepWheelSuspensionBuilder(shockPostPosition: shockPostPosiiton, springAttachmentPoint: springAttachmentPoint)
        case .humvee:
            builder = HumveeWheelSuspensionBuilder(shockPostPosition: shockPostPosiiton, springAttachmentPoint: springAttachmentPoint)
        case .schoolBus:
            builder = SchoolBusWheelSuspensionBuilder(shockPostPosition: shockPostPosiiton, springAttachmentPoint: springAttachmentPoint)
        case .balista:
            builder = BalistaWheelSuspensionBuilder(shockPostPosition: shockPostPosiiton, springAttachmentPoint: springAttachmentPoint)
        }
        return WheelSuspension(builder: builder, attachmentBody: chasis, attachmentWheel: wheelNode)
    }
}
