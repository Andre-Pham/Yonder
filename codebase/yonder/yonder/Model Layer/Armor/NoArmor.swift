//
//  NoArmor.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

class NoArmor: ArmorAbstract {
    
    public let name: String
    public let description: String
    public let basePurchasePrice = 0
    
    init(type: ArmorType) {
        self.name = Term.none.capitalized
        self.description = "No \(Term.armorSlot(of: type)) \(Term.armor) equipped."
        
        super.init(type: type, armorPoints: 0, armorBuffs: [])
    }
    
    func getPurchaseInfo() -> PurchaseableItemInfo {
        return PurchaseableItemInfo(name: self.name, description: self.description)
    }
    
    func beRecieved(by reciever: Player, amount: Int) {
        reciever.equipArmor(self)
    }
    
}
