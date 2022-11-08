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
    enum Tier: Int, CaseIterable {
        case I = 25
        case II = 50
        case III = 100
        case IV = 200
        case V = 400
        
        var string: String {
            switch self {
            case .I: return Strings("tier1").local
            case .II: return Strings("tier2").local
            case .III: return Strings("tier3").local
            case .IV: return Strings("tier4").local
            case .V: return Strings("tier5").local
            }
        }
        
        var damage: Int {
            return self.rawValue
        }
    }
    
    init(tier: Tier, potionCount: Int) {
        super.init(
            name: Strings("potion.damage.name").local.continuedBy(tier.string),
            description: Strings("potion.damage.description").local,
            effectsDescription: Strings("potion.damage.effectsDescription1Param").localWithArgs(tier.damage),
            remainingUses: potionCount,
            damage: tier.damage)
    }
    
    required init(_ original: PotionAbstract) {
        super.init(original)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract) {
        opposition.damageAdjusted(sourceOwner: owner, using: self, for: self.damage)
        self.adjustRemainingUses(by: -1)
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerDamageStat.getValue(amount: self.damage, uses: self.remainingUses)
    }
    
}
