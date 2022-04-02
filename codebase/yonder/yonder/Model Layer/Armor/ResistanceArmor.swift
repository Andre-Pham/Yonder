//
//  ResistanceArmor.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class ResistanceArmor: ArmorAbstract {
    
    public let name: String
    public let description: String
    public let basePurchasePrice: Int
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", type: ArmorType, armorPoints: Int, damageFraction: Double, basePurchasePrice: Int) {
        self.name = name
        self.description = description
        self.basePurchasePrice = basePurchasePrice
        
        super.init(
            type: type,
            armorPoints: armorPoints,
            armorBuffs: [DamagePercentBuff(direction: .incoming, duration: nil, damageFraction: damageFraction)]
        )
    }
    
    func getPurchaseInfo() -> PurchaseableItemInfo {
        return PurchaseableItemInfo(name: self.name, description: self.description)
    }
    
    func beRecieved(by reciever: Player, amount: Int) {
        reciever.equipArmor(self)
    }
    
}
