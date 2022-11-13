//
//  EnhancerProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 11/11/2022.
//

import Foundation

class EnhancerProfileBucket {
    
    private var profiles: [EnhancerProfile] = [
        // TODO: Populate
    ]
    
    func grabProfile(areaTag: AreaProfileTag) -> EnhancerProfile {
        var matchingIndices = [Int]()
        for (index, profile) in self.profiles.enumerated() {
            if profile.areaTags.contains(where: { $0 == areaTag }) {
                matchingIndices.append(index)
            }
        }
        let selectedIndex = Int.random(in: 0..<matchingIndices.count)
        return self.profiles.remove(at: selectedIndex)
    }
    
}