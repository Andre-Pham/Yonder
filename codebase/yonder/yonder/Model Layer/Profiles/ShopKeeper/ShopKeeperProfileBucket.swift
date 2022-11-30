//
//  ShopKeeperProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 10/11/2022.
//

import Foundation

class ShopKeeperProfileBucket {
    
    private var profiles: [ShopKeeperProfile] = [
        // TODO: Populate
    ]
    
    func grabProfile(areaTag: AreaProfileTag) -> ShopKeeperProfile {
        let randomProfile = RandomProfile(prefix: "Shop Keeper")
        return ShopKeeperProfile(
            shopKeeperName: randomProfile.name,
            shopKeeperDescription: randomProfile.description,
            areaTags: []
        )
        
        var matchingIndices = [Int]()
        for (index, profile) in self.profiles.enumerated() {
            if profile.matchesAreaTag(areaTag) {
                matchingIndices.append(index)
            }
        }
        let selectedIndex = Int.random(in: 0..<matchingIndices.count)
        return self.profiles.remove(at: selectedIndex)
    }
    
}
