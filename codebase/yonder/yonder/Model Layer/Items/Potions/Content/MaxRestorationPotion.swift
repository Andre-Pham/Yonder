//
//  MaxRestorationPotion.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class MaxRestorationPotion: Potion {
    
    init(potionCount: Int) {
        super.init(
            name: Strings("potion.maxRestoration.name").local,
            description: Strings("potion.maxRestoration.description").local,
            effectsDescription: Strings("potion.maxRestoration.effectsDescription").local,
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
        owner.restore(for: owner.maxHealth + owner.maxArmorPoints) // Max stats - no buffs adjustment needed
        self.adjustRemainingUses(by: -1)
    }
    
    func calculateBasePurchasePrice() -> Int {
        return (
            Pricing.playerHealthRestorationStat.getValue(amount: Pricing.playerHealthStat.baseStatAmount, uses: self.remainingUses) +
            Pricing.playerArmorPointsRestorationStat.getValue(amount: Pricing.playerArmorPointsStat.baseStatAmount, uses: self.remainingUses)
        )
    }
    
}
