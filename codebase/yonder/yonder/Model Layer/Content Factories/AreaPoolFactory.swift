//
//  AreaPoolFactory.swift
//  yonder
//
//  Created by Andre Pham on 10/11/2022.
//

import Foundation

class AreaPoolFactory {
    
    private let areaProfile: AreaProfile
    private let factoryBundle: AreaFactoryBundle
    
    init(areaProfile: AreaProfile, factoryBundle: AreaFactoryBundle) {
        self.areaProfile = areaProfile
        self.factoryBundle = factoryBundle
    }
    
    func deliver() -> AreaPool {
        let hostileLocations = self.factoryBundle.foeFactory
            .deliver(count: 20)
            .map({ HostileLocation(foe: $0) })
        let challengeHostileLocations = self.factoryBundle.challengeHostileFactory
            .deliver(count: 20)
            .map({ ChallengeHostileLocation(foe: $0) })
        
        // Now i'll need a shopkeeper factory, an enhancer factory, a restorer factory and a friendly factory
        
        let areaPool = AreaPool(
            areaName: self.areaProfile.areaName,
            areaDescription: self.areaProfile.areaDescription,
            areaImage: self.areaProfile.areaImage,
            hostileLocations: hostileLocations,
            challengeHostileLocations: challengeHostileLocations,
            shopLocations: <#T##[ShopLocation]#>,
            enhancerLocations: <#T##[EnhancerLocation]#>,
            restorerLocations: <#T##[RestorerLocation]#>,
            friendlyLocations: <#T##[FriendlyLocation]#>
        )
        return areaPool
    }
    
}
