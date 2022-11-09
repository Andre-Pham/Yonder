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
        let areaPool = AreaPool(
            areaName: self.areaProfile.areaName,
            areaDescription: self.areaProfile.areaDescription,
            areaImage: self.areaProfile.areaImage,
            hostileLocations: <#T##[HostileLocation]#>,
            challengeHostileLocations: <#T##[ChallengeHostileLocation]#>,
            shopLocations: <#T##[ShopLocation]#>,
            enhancerLocations: <#T##[EnhancerLocation]#>,
            restorerLocations: <#T##[RestorerLocation]#>,
            friendlyLocations: <#T##[FriendlyLocation]#>
        )
        return areaPool
    }
    
}
