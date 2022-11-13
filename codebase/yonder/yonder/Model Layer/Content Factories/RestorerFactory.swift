//
//  RestorerFactory.swift
//  yonder
//
//  Created by Andre Pham on 12/11/2022.
//

import Foundation

class RestorerFactory {
    
    private let stage: Int
    private let areaTags: AreaProfileTagAllocation
    private let restorerProfileBucket: RestorerProfileBucket
    
    init(stage: Int, areaTags: AreaProfileTagAllocation, restorerProfileBucket: RestorerProfileBucket) {
        self.stage = stage
        self.areaTags = areaTags
        self.restorerProfileBucket = restorerProfileBucket
    }
    
    private func buildRestorer(stage: Int, tags: AreaProfileTagAllocation) -> Restorer {
        // Out of 4 restorers, 1 is health, 1 is armor points, 2 is both
        var restoreOptions: [Restorer.RestoreOption]
        if Random.roll(1, in: 2) {
            restoreOptions = [.health, .armorPoints]
        } else if Random.roll(1, in: 2) {
            restoreOptions = [.armorPoints]
        } else {
            restoreOptions = [.health]
        }
        let profile = self.restorerProfileBucket.grabProfile(areaTag: tags.getTag(), restoreOptions: restoreOptions)
        return Restorers.newRestorer(profile: profile, stage: stage, restoreOptions: restoreOptions)
    }
    
    func deliver() -> Restorer {
        return self.buildRestorer(stage: self.stage, tags: self.areaTags)
    }
    
    func deliver(count: Int) -> [Restorer] {
        var restorers = [Restorer]()
        restorers.populate(count: count) {
            self.buildRestorer(stage: self.stage, tags: self.areaTags)
        }
        return restorers
    }
    
}
