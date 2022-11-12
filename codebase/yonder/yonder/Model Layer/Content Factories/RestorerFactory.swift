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
        // A discount is applied to restorer prices since otherwise potions would out-value them every time
        let healthFairValue = Pricing.usingStage(stage: stage) {
            Pricing.playerHealthRestorationStat.getValue(amount: 10)
        }
        let healthMinValue = (Double(healthFairValue)/2.0).toRoundedInt()
        let armorPointsFairValue = Pricing.usingStage(stage: stage) {
            Pricing.playerArmorPointsRestorationStat.getValue(amount: 10)
        }
        let armorPointsMinValue = (Double(armorPointsFairValue)/2.0).toRoundedInt()
        let healthPrice = Int.random(in: healthMinValue...healthFairValue)
        let armorPointsPrice = Int.random(in: armorPointsMinValue...armorPointsFairValue)
        return Restorer(
            name: profile.restorerName,
            description: profile.restorerDescription,
            options: restoreOptions,
            pricePerHealthBundle: healthPrice,
            pricePerArmorPointBundle: armorPointsPrice
        )
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
