//
//  WeaponProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class WeaponProfileBucket {
    
    private var profiles: [WeaponProfile] = [
        // TODO: Populate
    ]
    
    func grabProfile(areaTag: AreaProfileTag, weaponTag: WeaponProfileTag) -> WeaponProfile {
        var matchingIndices = [Int]()
        for (index, profile) in self.profiles.enumerated() {
            if (profile.areaTags.contains(where: { $0 == areaTag }) &&
                profile.weaponTags.contains(where: { $0 == weaponTag })
            ) {
                matchingIndices.append(index)
            }
        }
        let selectedIndex = Int.random(in: 0..<matchingIndices.count)
        return self.profiles.remove(at: selectedIndex)
    }
    
}
