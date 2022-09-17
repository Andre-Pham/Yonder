//
//  DamagePotion.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class DamagePotion: Potion {
    
    /// The tier of the damage potion. Greater tiers deal greater damage.
    /// Raw value represents the amount of damage of each tier.
    enum Tier: Int {
        case I = 25
        case II = 50
        case III = 100
        case IV = 200
        case V = 400
        
        var string: String {
            switch self {
            case .I: return Strings.Potion.Tier1.local
            case .II: return Strings.Potion.Tier2.local
            case .III: return Strings.Potion.Tier3.local
            case .IV: return Strings.Potion.Tier4.local
            case .V: return Strings.Potion.Tier5.local
            }
        }
        
        var damage: Int {
            return self.rawValue
        }
    }
    
    init(tier: Tier, potionCount: Int, basePurchasePrice: Int) {
        super.init(
            name: Strings.Potion.Damage.Name.local.continuedBy(tier.string),
            description: Strings.Potion.Damage.Description.local,
            effectsDescription: Strings.Potion.Damage.EffectsDescription1Param.localWithArgs(tier.damage),
            remainingUses: potionCount,
            damage: tier.damage,
            basePurchasePrice: basePurchasePrice)
    }
    
    required init(_ original: PotionAbstract) {
        super.init(original)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract) {
        opposition.damageAdjusted(sourceOwner: owner, using: self, for: self.damage)
        self.adjustRemainingUses(by: -1)
    }
    
}
