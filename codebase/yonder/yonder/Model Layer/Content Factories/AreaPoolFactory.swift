//
//  AreaPoolFactory.swift
//  yonder
//
//  Created by Andre Pham on 10/11/2022.
//

import Foundation

class AreaPoolFactory {
    
    private let areaProfile: RegionProfile
    
    init(areaProfile: RegionProfile) {
        self.areaProfile = areaProfile
    }
    
    func deliver() -> AreaPool {
        return AreaPool(
            areaName: self.areaProfile.regionName,
            areaDescription: self.areaProfile.regionDescription,
            areaBackground: self.areaProfile.regionBackground,
            areaForeground: self.areaProfile.regionForeground,
            tags: self.areaProfile.tags,
            hostileLocations: Array(count: 20, populateWith: HostileLocation()),
            challengeHostileLocations: Array(count: 20, populateWith: ChallengeHostileLocation()),
            shopLocations: Array(count: 6, populateWith: ShopLocation()),
            enhancerLocations: Array(count: 6, populateWith: EnhancerLocation()),
            restorerLocations: Array(count: 6, populateWith: RestorerLocation()),
            friendlyLocations: Array(count: 6, populateWith: FriendlyLocation())
        )
    }
    
}
