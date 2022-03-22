//
//  Potion.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

typealias PotionAbstract = PotionAbstractPart & Usable

class PotionAbstractPart: ItemAbstract, Purchasable {
    
    public let basePurchasePrice: Int
    
    init(name: String, description: String, remainingUses: Int = 0, damage: Int = 0, healthRestoration: Int = 0, basePurchasePrice: Int) {
        self.basePurchasePrice = basePurchasePrice
        
        super.init(name: name, description: description, remainingUses: remainingUses, damage: damage, healthRestoration: healthRestoration)
    }
    
    func isStackable(with potion: PotionAbstract) -> Bool {
        return self.damage == potion.damage && self.healthRestoration == potion.healthRestoration && self.name == potion.name && self.description == potion.description
    }
    
    func getPurchaseInfo() -> PurchaseableItemInfo {
        return PurchaseableItemInfo(name: self.name)
    }
    
    func beRecieved(by reciever: Player, amount: Int) {
        for _ in 0..<amount {
            reciever.addPotion(self as! PotionAbstract)
        }
    }
    
}
