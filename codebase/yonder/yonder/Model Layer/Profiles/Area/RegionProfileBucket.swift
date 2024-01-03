//
//  RegionProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation

class RegionProfileBucket {
    
    private var profiles: [[RegionProfile]] = [
        // TODO: Populate
        // Stage 0
        [
            RegionProfile(regionName: "TempArea", regionDescription: "TempDesc", regionImage: YonderImages.missingBackgroundImage, tags: RegionTagAllocation(tags: (.forest, 1)))
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
    
    func grabProfile(stage: Int) -> RegionProfile {
        let randomProfile = RandomProfile(prefix: "Area")
        return RegionProfile(
            regionName: randomProfile.name,
            regionDescription: randomProfile.description,
            regionImage: YonderImages.missingBackgroundImage,
            tags: RegionTagAllocation(tags: (.forest, 1))
        )
        
        assert(self.profiles.count > stage, "Requesting profile from non-existent stage")
        var stageProfiles = self.profiles[stage]
        assert(!stageProfiles.isEmpty, "Attempted to grab a profile when there are none left for the provided stage")
        let index = Int.random(in: 0..<stageProfiles.count)
        return stageProfiles.remove(at: index)
    }
    
    func grabProfiles(count: Int, stage: Int) -> [RegionProfile] {
        var profiles = [RegionProfile]()
        for _ in 0..<count {
            profiles.append(self.grabProfile(stage: stage))
        }
        return profiles
    }
    
}
