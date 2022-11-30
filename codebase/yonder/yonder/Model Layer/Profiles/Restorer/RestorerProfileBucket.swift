//
//  RestorerProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 11/11/2022.
//

import Foundation

class RestorerProfileBucket {
    
    private var profiles: [RestorerProfile] = [
        // TODO: Populate
    ]
    
    func grabProfile(areaTag: AreaProfileTag, restoreOptions: [Restorer.RestoreOption]) -> RestorerProfile {
        let randomProfile = RandomProfile(prefix: "Restorer")
        return RestorerProfile(
            restorerName: randomProfile.name,
            restorerDescription: randomProfile.description,
            areaTags: [],
            restoreOptions: []
        )
        
        var matchingIndices = [Int]()
        let allocation = RestoreOptionsAllocation(options: restoreOptions)
        for (index, profile) in self.profiles.enumerated() {
            if (profile.matchesAreaTag(areaTag) && profile.restoreOptions.optionsCode == allocation.optionsCode) {
                matchingIndices.append(index)
            }
        }
        let selectedIndex = Int.random(in: 0..<matchingIndices.count)
        return self.profiles.remove(at: selectedIndex)
    }
    
}
