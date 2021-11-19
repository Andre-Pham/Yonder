//
//  ResistanceArmor.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class ResistanceArmor: ArmorAbstract {
    
    let type: ArmorType
    public private(set) var armorPoints: Int
    public private(set) var armorBuffs = [BuffAbstract]()
    
    init(type: ArmorType, armorPoints: Int, damageFraction: Double) {
        self.type = type
        self.armorPoints = armorPoints
        self.armorBuffs.append(DamagePercentBuff(duration: INFINITY, damageFraction: damageFraction))
    }
    
}
