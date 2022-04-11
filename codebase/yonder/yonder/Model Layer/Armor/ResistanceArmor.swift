//
//  ResistanceArmor.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class ResistanceArmor: ArmorAbstract {
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", type: ArmorType, armorPoints: Int, damageFraction: Double, basePurchasePrice: Int) {
        
        super.init(
            name: name,
            description: description,
            type: type,
            armorPoints: armorPoints,
            basePurchasePrice: basePurchasePrice,
            armorBuffs: [DamagePercentBuff(direction: .incoming, duration: nil, damageFraction: damageFraction)]
        )
    }
    
}
