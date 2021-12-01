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
    public let basePurchasePrice: Int
    public let purchaseType: PurchasableType = .armor
    
    init(type: ArmorType, armorPoints: Int, damageFraction: Double, basePurchasePrice: Int) {
        self.type = type
        self.armorPoints = armorPoints
        self.basePurchasePrice = basePurchasePrice
        self.armorBuffs.append(DamagePercentBuff(duration: INFINITY, damageFraction: damageFraction))
    }
    
}
