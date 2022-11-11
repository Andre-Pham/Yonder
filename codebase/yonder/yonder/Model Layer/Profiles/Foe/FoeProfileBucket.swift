//
//  FoeProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation

class FoeProfileBucket {
    
    private var profiles: [FoeProfile] = [
        // TODO: Populate
    ]
    
    func grabProfile(areaTag: AreaProfileTag, foeTag: FoeProfileTag) -> FoeProfile {
        var matchingIndices = [Int]()
        for (index, profile) in self.profiles.enumerated() {
            if profile.areaTags.contains(where: { $0 == areaTag }) && profile.foeTags.contains(where: { $0 == foeTag }) {
                matchingIndices.append(index)
            }
        }
        let selectedIndex = Int.random(in: 0..<matchingIndices.count)
        return self.profiles.remove(at: selectedIndex)
    }
    
}
