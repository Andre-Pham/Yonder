//
//  WeaknessPotion.swift
//  yonder
//
//  Created by Andre Pham on 26/9/2022.
//

import Foundation

class WeaknessPotion: Potion {
    
    /// The tier of the weakness potion.
    /// Raw value represents the damage fraction of each tier.
    enum Tier: Double {
        case I = 0.8
        case II = 0.5
        case III = 0.2
        
        var string: String {
            switch self {
            case .I: return Strings.Tier1.local
            case .II: return Strings.Tier2.local
            case .III: return Strings.Tier3.local
            }
        }
        
        var damageFraction: Double {
            return self.rawValue
        }
    }
    
    private let buff: DamagePercentBuff
    
    /// To determine if potion is stackable
    private let duration: Int
    private let tier: Tier
    
    init(tier: Tier, duration: Int, potionCount: Int, basePurchasePrice: Int) {
        let name = Strings.Potion.Weakness.Name.local.continuedBy(tier.string)
        self.buff = DamagePercentBuff(sourceName: name, direction: .outgoing, duration: duration, damageFraction: tier.damageFraction)
        self.duration = duration
        self.tier = tier
        super.init(
            name: name,
            description: Strings.Potion.Weakness.Description.local,
            effectsDescription: Strings.Potion.ApplyToFoe.local.continuedBy(self.buff.getEffectsDescription() ?? ""),
            remainingUses: potionCount,
            basePurchasePrice: basePurchasePrice)
        assert(self.buff.getEffectsDescription() != nil, "Buff that should have an effects description doesn't have one")
    }
    
    required init(_ original: PotionAbstract) {
        let original = original as! Self
        self.buff = original.buff.clone()
        self.duration = original.duration
        self.tier = original.tier
        super.init(original)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract) {
        opposition.addBuff(self.buff)
        self.adjustRemainingUses(by: -1)
    }
    
    override func isStackable(with potion: Potion) -> Bool {
        if let potion = potion as? Self {
            return (super.isStackable(with: potion) &&
                    self.duration == potion.duration &&
                    self.tier == potion.tier)
        }
        return false
    }
    
}
