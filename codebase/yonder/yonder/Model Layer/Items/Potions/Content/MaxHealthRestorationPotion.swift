//
//  MaxHealthRestorationPotion.swift
//  yonder
//
//  Created by Andre Pham on 18/6/2022.
//

import Foundation

class MaxHealthRestorationPotion: Potion {
    
    init(potionCount: Int) {
        super.init(
            name: Strings("potion.maxHealthRestoration.name").local,
            description: Strings("potion.maxHealthRestoration.description").local,
            effectsDescription: Strings("potion.maxHealthRestoration.effectsDescription").local,
            remainingUses: potionCount,
            requiresFoeForUsage: false
        )
    }
    
    required init(_ original: PotionAbstract) {
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
        owner.restoreHealth(for: owner.maxHealth) // Max health - no buffs adjustment needed
        self.adjustRemainingUses(by: -1)
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerHealthRestorationStat.getValue(amount: Pricing.playerHealthStat.baseStatAmount, uses: self.remainingUses)
    }
    
}
