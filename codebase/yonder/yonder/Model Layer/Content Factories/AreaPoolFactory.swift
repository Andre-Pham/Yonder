//
//  AreaPoolFactory.swift
//  yonder
//
//  Created by Andre Pham on 10/11/2022.
//

import Foundation

class AreaPoolFactory {
    
    private let areaProfile: AreaProfile
    
    init(areaProfile: AreaProfile) {
        self.areaProfile = areaProfile
    }
    
    func deliver() -> AreaPool {
        return AreaPool(
            areaName: self.areaProfile.areaName,
            areaDescription: self.areaProfile.areaDescription,
            areaImageResource: self.areaProfile.areaImageResource,
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
