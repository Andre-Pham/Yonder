//
//  ArmorProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 9/11/2022.
//

import Foundation

class ArmorProfileBucket {
    
    private var profiles: [ArmorProfile] = [
        // Populate
    ]
    
    func grabProfile(areaTag: AreaProfileTag, armorTag: ArmorProfileTag, armorType: ArmorType) -> ArmorProfile {
        var matchingIndices = [Int]()
        for (index, profile) in self.profiles.enumerated() {
            if (profile.areaTags.contains(where: { $0 == areaTag }) &&
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
