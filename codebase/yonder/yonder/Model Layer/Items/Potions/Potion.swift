//
//  Potion.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

typealias PotionAbstract = PotionAbstractPart & Usable

class PotionAbstractPart: ItemAbstract, Purchasable, Clonable {
    
    public let basePurchasePrice: Int
    private let effectsDescription: String?
    var potionCount: Int {
        return self.remainingUses
    }
    
    init(name: String, description: String, effectsDescription: String?, remainingUses: Int = 0, damage: Int = 0, healthRestoration: Int = 0, armorPointsRestoration: Int = 0, basePurchasePrice: Int) {
        self.basePurchasePrice = basePurchasePrice
        self.effectsDescription = effectsDescription
        
        super.init(name: name, description: description, remainingUses: remainingUses, damage: damage, healthRestoration: healthRestoration, armorPointsRestoration: armorPointsRestoration)
    }
    
    required init(_ original: PotionAbstractPart) {
        self.basePurchasePrice = original.basePurchasePrice
        self.effectsDescription = original.effectsDescription
        
        super.init(name: original.name, description: original.description, remainingUses: original.remainingUses, damage: original.damage, healthRestoration: original.healthRestoration, armorPointsRestoration: original.armorPointsRestoration, infiniteRemainingUses: original.infiniteRemainingUses)
    }
    
    func getEffectsDescription() -> String? {
        return self.effectsDescription
    }
    
    func isStackable(with potion: PotionAbstract) -> Bool {
        return self.damage == potion.damage && self.healthRestoration == potion.healthRestoration && self.armorPointsRestoration == potion.armorPointsRestoration && self.name == potion.name && self.description == potion.description
    }
    
    func getPurchaseInfo() -> PurchasableItemInfo {
        return PurchasableItemInfo(name: self.name, description: self.description, type: .potion)
    }
    
    func beReceived(by receiver: Player, amount: Int) {
        for _ in 0..<amount {
            receiver.addPotion(self as! PotionAbstract)
        }
    }
    
    override func remainingUsesDidSet() {
        if self.remainingUses == 0 {
            OnNoPotionsRemainingPublisher.publish(potion: self as! PotionAbstract)
        }
    }
    
}
