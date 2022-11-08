//
//  AreaPoolFactory.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation

class AreaPoolFactory {
    
    private let areaProfileBucket = AreaProfileBucket()
    
    func build(stage: Int) -> AreaPool {
        let areaProfile = self.areaProfileBucket.grabProfile(stage: stage)
        
        var areaWeaponFactory = WeaponFactory(stage: stage, areaTags: areaProfile.tags)
        var areaPotionFactory = PotionFactory(stage: stage)
        var areaArmorFactory = ArmorFactory(stage: stage, areaTags: areaProfile.tags)
        // I'll need to pass all the loot into the areaFoes so it can take it from that
        var areaFoeFactory = FoeFactory(stage: stage, areaTags: areaProfile.tags)
        
        
        let areaPool = AreaPool(
            areaName: areaProfile.areaName,
            areaDescription: areaProfile.areaDescription,
            areaImage: areaProfile.areaImage,
            hostileLocations: <#T##[HostileLocation]#>,
            challengeHostileLocations: <#T##[ChallengeHostileLocation]#>,
            shopLocations: <#T##[ShopLocation]#>,
            enhancerLocations: <#T##[EnhancerLocation]#>,
            restorerLocations: <#T##[RestorerLocation]#>,
            friendlyLocations: <#T##[FriendlyLocation]#>
        )
    }
    
}
