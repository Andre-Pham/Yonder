//
//  AllRestorers.swift
//  yonder
//
//  Created by Andre Pham on 27/12/21.
//

import Foundation

enum Restorers {
    
    static func newRestorer(profile: RestorerProfile, stage: Int, restoreOptions: [Restorer.RestoreOption]) -> Restorer {
        let restorer = Restorers.newRestorerNoProfile(stage: stage, restoreOptions: restoreOptions)
        restorer.overrideProfileContent(contentID: profile.id, name: profile.restorerName, description: profile.restorerDescription)
        return restorer
    }
    
    static func newRestorerNoProfile(stage: Int, restoreOptions: [Restorer.RestoreOption]) -> Restorer {
        // A discount is applied to restorer prices since otherwise potions would out-value them every time
        let healthFairValue = Pricing.usingStage(stage: stage) {
            Pricing.playerHealthRestorationStat.getValue(amount: 10)
        }
        let healthMinValue = (Double(healthFairValue)/1.5).toRoundedInt()
        let armorPointsFairValue = Pricing.usingStage(stage: stage) {
            Pricing.playerArmorPointsRestorationStat.getValue(amount: 10)
        }
        let armorPointsMinValue = (Double(armorPointsFairValue)/1.5).toRoundedInt()
        let healthPrice = Int.random(in: healthMinValue...healthFairValue)
        let armorPointsPrice = Int.random(in: armorPointsMinValue...armorPointsFairValue)
        return Restorer(
            contentID: nil,
            name: "",
            description: "",
            options: restoreOptions,
            pricePerHealthBundle: healthPrice,
            pricePerArmorPointBundle: armorPointsPrice
        )
    }
    
}
