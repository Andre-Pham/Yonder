//
//  MaxRestoreAllConsumable.swift
//  yonder
//
//  Created by Andre Pham on 24/11/2022.
//

import Foundation

class MaxRestoreAllConsumable: Consumable {
    
    init(amount: Int) {
        super.init(
            name: Strings("consumable.maxRestoreAll.name").local,
            description: Strings("consumable.maxRestoreAll.description").local,
            effectsDescription: Strings("consumable.maxRestoreAll.effectsDescription").local,
            requiresFoeForUsage: true,
            remainingUses: amount
        )
    }
    
    required init(_ original: ConsumableAbstract) {
        super.init(original)
    }
    
    // MARK: - Serialisation
    
    required init(dataObject: DataObject) {
        super.init(dataObject: dataObject)
    }
    
    override func toDataObject() -> DataObject {
        return super.toDataObject()
    }
    
    // MARK: - Functions
    
    func use(owner: ActorAbstract, opposition: ActorAbstract?) {
        guard let opposition else {
            assertionFailure("Consumable that requires an opposition is being used without one")
            return
        }
        opposition.restore(for: opposition.maxHealth + opposition.maxArmorPoints)
        owner.restore(for: owner.maxHealth + owner.maxArmorPoints)
        self.adjustRemainingUses(by: -1)
    }
    
    func isStackable(with consumable: Consumable) -> Bool {
        return consumable is Self
    }
    
    func calculateBasePurchasePrice() -> Int {
        // If you do a "fair" calculation, this has a symmetric effect so the price often comes out to 0 (or close)
        // (The closer to stage 0, the closer to 0)
        // Obviously this does have value - the player could start a fight on 1hp and use this and the foe would have no benefit
        // As a compromise this will be worth half what a regular max restore is
        return MaxHealthRestorationPotion(potionCount: self.remainingUses).getBasePurchasePrice()/2
    }
    
}
