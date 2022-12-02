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
        let playerBaseHitPoints = Pricing.playerHealthStat.baseStatAmount + Pricing.playerArmorPointsStat.baseStatAmount
        let foeBaseHitPoints = Pricing.foeHealthStat.baseStatAmount + Pricing.foeArmorPointsStat.baseStatAmount
        return Pricing.playerHealthRestorationStat.getValue(amount: playerBaseHitPoints, uses: self.remainingUses) - Pricing.playerDamageStat.getValue(amount: foeBaseHitPoints, uses: self.remainingUses)
    }
    
}
