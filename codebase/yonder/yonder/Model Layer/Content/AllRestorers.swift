//
//  AllRestorers.swift
//  yonder
//
//  Created by Andre Pham on 27/12/21.
//

import Foundation

enum Restorers {
    
    // MARK: - Test Restorers
    
    static func newTestRestorer() -> Restorer {
        return Restorer(options: [.armorPoints, .health], pricePerHealthBundle: 10, pricePerArmorPointBundle: 15)
    }
    
    static func newRestorer(profile: RestorerProfile, stage: Int, restoreOptions: [Restorer.RestoreOption]) -> Restorer {
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
    
}
