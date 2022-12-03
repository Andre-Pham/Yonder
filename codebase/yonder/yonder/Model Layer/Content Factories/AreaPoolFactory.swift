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
        let shopLocations = self.factoryBundle.interactorFactories.shopKeeperFactory
            .deliver(count: 6)
            .map({ ShopLocation(shopKeeper: $0) })
        let enhancerLocations = self.factoryBundle.interactorFactories.enhancerFactory
            .deliver(count: 6)
            .map({ EnhancerLocation(enhancer: $0) })
        let restorerLocations = self.factoryBundle.interactorFactories.restorerFactory
            .deliver(count: 6)
            .map({ RestorerLocation(restorer: $0) })
        let friendlyLocations = self.factoryBundle.interactorFactories.friendlyFactory
            .deliver(count: 6)
            .map({ FriendlyLocation(friendly: $0) })
        return AreaPool(
            areaName: self.areaProfile.areaName,
            areaDescription: self.areaProfile.areaDescription,
            areaImageResource: self.areaProfile.areaImageResource,
            hostileLocations: hostileLocations,
            challengeHostileLocations: challengeHostileLocations,
            shopLocations: shopLocations,
            enhancerLocations: enhancerLocations,
            restorerLocations: restorerLocations,
            friendlyLocations: friendlyLocations
        )
    }
    
}
