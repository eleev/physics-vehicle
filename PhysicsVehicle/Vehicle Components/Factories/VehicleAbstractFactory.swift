//
//  VehicleAbstractFactory.swift
//  ios-spritekit-physics-racing
//
//  Created by Astemir Eleev on 14/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

enum VehicleFactoryError: Error {
    case couldNotProdicePhysicsWheel(String)
}

struct VehcileAbstractFactory {
    
    // MARK: - Properties
    
    private let chasisFactory = ChasisFactory()
    private let suspensionFactory = SuspentionFactory()
    private let wheelFactory = WheelFactory()
    
    // MARK: - Methods
    
    func produce(type: VehicleType, at position: CGPoint) throws -> Vehicle {
        // Prepare Chasis
        let chasis = chasisFactory.produce(of: type, at: position)
        
        // Create Wheels and Engine
        var wheelBuilder: WheelsLocationBuilder!
        var engine: Engine
        
        switch type {
        case .jeep:
            wheelBuilder = JeepWheelsLocationBuilder(chasis: chasis)
            engine = .jeepStandard(JeepStandardEngineConfiguration())
        case .humvee:
            wheelBuilder = HumveeWheelsLocationBuilder(chasis: chasis)
            engine = .humvee(HumveeEngineConfiguration())
        case .schoolBus:
            wheelBuilder = SchoolBusWheelsLocationBuilder(chasis: chasis)
            engine = .schoolBus(SchoolBusEngineConfiguration())
        case .balista:
            wheelBuilder = BalistaWheelsLocationBuilder(chasis: chasis)
            engine = .balista(BalistaEngineConfiguration())
        }
        var wheels = [PhysicsWheel]()
        
        for wheel in wheelBuilder.locations {
            guard let physicsWheel = produce(type: type,
                    at: wheel.wheelLocation,
                    using: chasis,
                    shockPostPosition: wheel.shockPostLocation,
                    springAttachmentPoint: wheel.springAttachmentLocation,
                    isBreakable: wheel.isBreakable) else {
                        print(#file, #line, #function, "Could not create a PhysicsWheel")
                        continue
            }
            wheels += [physicsWheel]
        }
        
        // Finally create the Vehicle
        return Vehicle(position: position,
                       chasis: chasis,
                       engine: engine,
                       wheels: wheels)
    }
    
    // MARK: - Private producers
    
    /// Produces a `PhysicsWheel` instance
    ///
    /// - Parameters:
    ///   - type: is a type of the target vehicle
    ///   - position: is a spatial location of a vehicle
    ///   - chasis: is a `Chasis` instance
    ///   - shockPostOffset: is a `CGPoint` with offsets
    ///   - shockPostPosition: is a `CGPoint` with offsets
    ///   - springAttachmentPoint: is a `CGPoint` with offsets
    /// - Returns: a fully constructed `PhysicsWheel` instance
    private func produce(type: VehicleType, at position: CGPoint, using chasis: ChasisNode, shockPostPosition: CGPoint, springAttachmentPoint: CGPoint, isBreakable: Bool) -> PhysicsWheel? {
        
        let wheelNode = wheelFactory.produce(of: type, at: position)
        guard let suspension = suspensionFactory.produce(of: type,
                                                   wheelNode: wheelNode,
                                                   chasis: chasis,
                                                   shockPostPosiiton: shockPostPosition,
                                                   springAttachmentPoint: springAttachmentPoint) else {
                                                    return nil
        }
        let physicsWheel = wheelFactory.produce(with: wheelNode, using: suspension, isBreakable: isBreakable)
        return physicsWheel
    }
    
}
