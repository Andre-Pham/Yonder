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
        var matchingIndices = [Int]()
        let allocation = RestoreOptionsAllocation(options: restoreOptions)
        for (index, profile) in self.profiles.enumerated() {
            if (profile.areaTags.contains(where: { $0 == areaTag }) &&
                profile.restoreOptions.optionsCode == allocation.optionsCode
            ) {
                matchingIndices.append(index)
            }
        }
        let selectedIndex = Int.random(in: 0..<matchingIndices.count)
        return self.profiles.remove(at: selectedIndex)
    }
    
}
