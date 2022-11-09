//
//  AreaProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation

class AreaProfileBucket {
    
    private var profiles: [[AreaProfile]] = [
        // Stage 0
        [
            AreaProfile(areaName: "TempArea", areaDescription: "TempDesc", areaImage: YonderImages.missingIcon, tags: AreaProfileTagAllocation(tags: (.wood, 1)))
        ],
        // Stage 1
        [
        ],
        // Stage 2
        [
        ],
        // Stage 3
        [
        ],
        // Stage 4
        [
        ],
        // Stage 5
        [
        ],
        // Stage 6
        [
        ],
        // Stage 7
        [
        ],
    ]
    
    func grabProfile(stage: Int) -> AreaProfile {
        assert(self.profiles.count > stage, "Requesting profile from non-existent stage")
        var stageProfiles = self.profiles[stage]
        assert(!stageProfiles.isEmpty, "Attempted to grab a profile when there are none left for the provided stage")
        let index = Int.random(in: 0..<stageProfiles.count)
        return stageProfiles.remove(at: index)
    }
    
    func grabProfiles(count: Int, stage: Int) -> [AreaProfile] {
        var profiles = [AreaProfile]()
        for _ in 0..<count {
            profiles.append(self.grabProfile(stage: stage))
        }
        return profiles
    }
    
}
