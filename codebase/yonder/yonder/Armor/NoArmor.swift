//
//  NoArmor.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

class NoArmor: ArmorAbstract {
    
    public let basePurchasePrice = 0
    
    init(type: ArmorType) {
        super.init(type: type, armorPoints: 0, armorBuffs: [])
    }
    
}
