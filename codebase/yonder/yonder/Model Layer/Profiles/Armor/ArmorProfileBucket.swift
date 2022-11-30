//
//  ArmorProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 9/11/2022.
//

import Foundation

class ArmorProfileBucket {
    
    private var profiles: [ArmorProfile] = [
        // TODO: Populate
    ]
    
    func grabProfile(areaTag: AreaProfileTag, armorTag: ArmorProfileTag, armorType: ArmorType) -> ArmorProfile {
        let randomProfile = RandomProfile(prefix: "Armor")
        return ArmorProfile(
            armorName: randomProfile.name,
            armorDescription: randomProfile.description,
            areaTags: [],
            armorTag: .heavyweight,
            armorType: .body
        )
        
        var matchingIndices = [Int]()
        for (index, profile) in self.profiles.enumerated() {
            if (profile.matchesAreaTag(areaTag) &&
                profile.armorTag == armorTag &&
                profile.armorType == armorType
            ) {
                matchingIndices.append(index)
            }
        }
        let selectedIndex = Int.random(in: 0..<matchingIndices.count)
        return self.profiles.remove(at: selectedIndex)
    }
    
}
