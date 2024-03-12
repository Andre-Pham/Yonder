//
//  BossFactory.swift
//  yonder
//
//  Created by Andre Pham on 13/3/2024.
//

import Foundation

class BossFactory: RegionBasedFactory {
    
    private let stage: Int
    private let regionTags: RegionTagAllocation
    private let bossProfileBucket: BossProfileBucket
    
    init(stage: Int, regionTags: RegionTagAllocation, profileBucket: BossProfileBucket) {
        self.stage = stage
        self.regionTags = regionTags
        self.bossProfileBucket = profileBucket
    }
    
    private func createBoss() -> Foe {
        // This gets all possible boss types for the stage, and picks a random
        // Since only a single boss is generated for each stage, we don't need to worry about getting a duplicate/repeat
        let profile = self.bossProfileBucket.grabProfile(areaTag: self.regionTags.getTag())
        return Bosses.allBossOptions(stage: self.stage, profile: profile).randomElement()!
    }
    
    func deliver() -> Foe {
        return self.createBoss()
    }
    
    func deliver(count: Int) -> [Foe] {
        return Array(count: count, populateWith: self.createBoss())
    }
    
    func deliverRegionTag() -> RegionProfileTag {
        return self.regionTags.getTag()
    }
    
}
