//
//  ResistanceArmor.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class ResistanceArmor: ArmorAbstract {
    
    public let basePurchasePrice: Int
    
    init(type: ArmorType, armorPoints: Int, damageFraction: Double, basePurchasePrice: Int) {
        self.basePurchasePrice = basePurchasePrice
        
        super.init(
            type: type,
            armorPoints: armorPoints,
            armorBuffs: [DamagePercentBuff(duration: Constants.infinity, damageFraction: damageFraction)]
        )
    }
    
}
