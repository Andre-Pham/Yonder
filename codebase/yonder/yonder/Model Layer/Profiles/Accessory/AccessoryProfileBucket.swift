//
//  AccessoryProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 9/11/2022.
//

import Foundation

class AccessoryProfileBucket {
    
    private var profiles: [AccessoryProfile] = [
        // TODO: Populate
        
        // Note to self:
        // accessoryType should play a role in the profile, e.g. a shield would be a peripheral accessory, a ring would be a regular accessory
        // areaTags are the areas that you could find this accessory in, e.g. "snow ring" would be odd to find in the firelands
        // (I need to add an "all" option for area profile tags)
    ]
    
    func grabProfile(areaTag: AreaProfileTag, accessoryTag: AccessoryProfileTag, accessoryType: AccessoryType) -> AccessoryProfile {
        let randomProfile = RandomProfile(prefix: "Accessory")
        return AccessoryProfile(
            accessoryName: randomProfile.name,
            accessoryDescription: randomProfile.description,
            areaTags: [],
            accessoryTag: .everything,
            accessoryType: .regular
        )
        
        var matchingIndices = [Int]()
        for (index, profile) in self.profiles.enumerated() {
            if (profile.matchesAreaTag(areaTag) &&
                profile.accessoryTag == accessoryTag &&
                profile.accessoryType == accessoryType
            ) {
                matchingIndices.append(index)
            }
        }
        let selectedIndex = Int.random(in: 0..<matchingIndices.count)
        return self.profiles.remove(at: selectedIndex)
    }
    
}
