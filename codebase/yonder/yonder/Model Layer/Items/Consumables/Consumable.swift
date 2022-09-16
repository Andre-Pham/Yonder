//
//  Consumable.swift
//  yonder
//
//  Created by Andre Pham on 14/9/2022.
//

import Foundation

typealias ConsumableAbstract = ConsumableAbstractPart & AlwaysUsable & ConsumableIsStackable

class ConsumableAbstractPart: ItemAbstract, Clonable, Purchasable {
    
    public let basePurchasePrice: Int
    @DidSetPublished private(set) var effectsDescription: String? = nil
    
    init(name: String, description: String, effectsDescription: String?, basePurchasePrice: Int, requiresFoeForUsage: Bool = false, damage: Int = 0, restoration: Int = 0, healthRestoration: Int = 0, armorPointsRestoration: Int = 0) {
        self.effectsDescription = effectsDescription
        self.basePurchasePrice = basePurchasePrice
        super.init(name: name, description: description, remainingUses: 1, damage: damage, restoration: restoration, healthRestoration: healthRestoration, armorPointsRestoration: armorPointsRestoration, requiresFoeForUsage: requiresFoeForUsage)
    }
    
    required init(_ original: ConsumableAbstractPart) {
        self.effectsDescription = original.effectsDescription
        self.basePurchasePrice = original.basePurchasePrice
        super.init(name: original.name, description: original.description, remainingUses: original.remainingUses, damage: original.damage, restoration: original.restoration, healthRestoration: original.healthRestoration, armorPointsRestoration: original.armorPointsRestoration, requiresFoeForUsage: original.requiresFoeForUsage)
    }
    
    func setEffectsDescription(to effectsDescription: String) {
        self.effectsDescription = effectsDescription
    }
    
    func getPurchaseInfo() -> PurchasableItemInfo {
        return PurchasableItemInfo(name: self.name, description: self.description, type: .consumable)
    }
    
    func beReceived(by receiver: Player, amount: Int) {
        if amount > 1 {
            self.setRemainingUses(to: self.remainingUses*amount)
        }
        receiver.addConsumable(self as! ConsumableAbstract)
    }
    
    func getEffectsDescription() -> String? {
        return self.effectsDescription
    }
    
    override func remainingUsesDidSet() {
        if self.remainingUses <= 0 {
            OnNoConsumablesRemainingPublisher.publish(consumable: self as! ConsumableAbstract)
        }
    }
    
}
