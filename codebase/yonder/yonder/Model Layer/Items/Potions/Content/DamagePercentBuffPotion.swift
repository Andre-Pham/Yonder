//
//  DamagePercentBuffPotion.swift
//  yonder
//
//  Created by Andre Pham on 24/6/2022.
//

import Foundation

class DamagePercentBuffPotion: Potion {
    
    /// The tier of the damage percent potion.
    /// Raw value represents the damage fraction of each tier.
    enum Tier: Double {
        case I = 1.2
        case II = 1.5
        case III = 2.0
        
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
        let name = Strings.Potion.DamagePercent.Name.local.continuedBy(tier.string)
        self.buff = DamagePercentBuff(sourceName: name, direction: .outgoing, duration: duration, damageFraction: tier.damageFraction)
        self.duration = duration
        self.tier = tier
        super.init(
            name: name,
            description: Strings.Potion.DamagePercent.Description.local,
            effectsDescription: self.buff.getEffectsDescription(),
            remainingUses: potionCount,
            basePurchasePrice: basePurchasePrice)
    }
    
    required init(_ original: PotionAbstract) {
        let original = original as! Self
        self.buff = original.buff.clone()
        self.duration = original.duration
        self.tier = original.tier
        super.init(original)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract) {
        owner.addBuff(self.buff)
        self.adjustRemainingUses(by: -1)
    }
    
    override func isStackable(with potion: Potion) -> Bool {
        if let potion = potion as? DamagePercentBuffPotion {
            return (super.isStackable(with: potion) &&
                    self.duration == potion.duration &&
                    self.tier == potion.tier)
        }
        return false
    }
    
}
