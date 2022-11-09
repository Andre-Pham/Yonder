//
//  AllAccessories.swift
//  yonder
//
//  Created by Andre Pham on 9/11/2022.
//

import Foundation

enum Accessories {
    
    static func resistanceAccessory(profile: AccessoryProfile, stage: Int, type: AccessoryType) -> Accessory {
        let resistanceRange = (type == .regular ? (0.05, 0.25) : (0.25, 0.5))
        let damageFractionPercent = Random.selectFromLinearDistribution(
            min: resistanceRange.0,
            max: resistanceRange.1,
            minY: 10,
            maxY: 1
        ).nearest(0.05)
        return Accessory(
            name: profile.accessoryName,
            description: profile.accessoryDescription,
            type: type,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [
                DamagePercentBuff(
                    sourceName: profile.accessoryName,
                    direction: .incoming,
                    duration: nil,
                    damageFraction: damageFractionPercent
                )
            ],
            equipmentPills: []
        )
    }
    
}
