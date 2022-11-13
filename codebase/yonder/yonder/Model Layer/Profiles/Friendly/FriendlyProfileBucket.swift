//
//  FriendlyProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class FriendlyProfileBucket {
    
    private var profiles: [FriendlyProfile] = [
        // TODO: Populate
    ]
    
    func grabProfile(areaTag: AreaProfileTag, friendlyTag: FriendlyProfileTag) -> FriendlyProfile {
        var matchingIndices = [Int]()
        for (index, profile) in self.profiles.enumerated() {
            if (profile.areaTags.contains(where: { $0 == areaTag }) && profile.friendlyTag == friendlyTag) {
                matchingIndices.append(index)
            }
        }
        let selectedIndex = Int.random(in: 0..<matchingIndices.count)
        return self.profiles.remove(at: selectedIndex)
    }
    
}
