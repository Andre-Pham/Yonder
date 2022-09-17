//
//  BonusHealthConsumable.swift
//  yonder
//
//  Created by Andre Pham on 7/9/2022.
//

import Foundation

/// Gives the user permanent bonus health.
class BonusHealthConsumable: ConsumableAbstract {
    
    enum Tier: Int {
        case I = 25
        case II = 50
        case III = 100
        case IV = 200
        
        var amount: Int {
            return self.rawValue
        }
    }
    
    public let tier: Tier
    
    init(basePurchasePrice: Int, tier: Tier) {
        self.tier = tier
        
        var name: String
        var description: String
        switch tier {
        case .I:
            name = Strings.Consumable.AdjustMaxHealth.Name.Tier1.local
            description = Strings.Consumable.AdjustMaxHealth.Description.Tier1.local
        case .II:
            name = Strings.Consumable.AdjustMaxHealth.Name.Tier2.local
            description = Strings.Consumable.AdjustMaxHealth.Description.Tier2.local
        case .III:
            name = Strings.Consumable.AdjustMaxHealth.Name.Tier3.local
            description = Strings.Consumable.AdjustMaxHealth.Description.Tier3.local
        case .IV:
            name = Strings.Consumable.AdjustMaxHealth.Name.Tier4.local
            description = Strings.Consumable.AdjustMaxHealth.Description.Tier4.local
        }
        super.init(
            name: name,
            description: description,
            effectsDescription: Strings.Consumable.AdjustMaxHealth.EffectsDescription1Param.localWithArgs(tier.amount),
            basePurchasePrice: basePurchasePrice
        )
    }
    
    required init(_ original: ConsumableAbstractPart) {
        let original = original as! Self
        self.tier = original.tier
        super.init(original)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract?) {
        owner.adjustBonusHealth(by: self.tier.amount)
        self.adjustRemainingUses(by: -1)
    }
    
    func isStackable(with consumable: ConsumableAbstract) -> Bool {
        if let consumable = consumable as? Self {
            return consumable.tier == self.tier
        }
        return false
    }
    
}
