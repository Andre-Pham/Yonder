//
//  DamageBuffAllConsumable.swift
//  yonder
//
//  Created by Andre Pham on 24/11/2022.
//

import Foundation

/// Gives substantial damage buffs to both the player and the foe.
class DamageBuffAllConsumable: Consumable {
    
    /// The tier of the consumable. Greater tiers give bigger buffs.
    enum Tier: Double, CaseIterable {
        case I = 1.5
        case II = 2.0
        case III = 3.0
        
        var string: String {
            switch self {
            case .I: return Strings("tier1").local
            case .II: return Strings("tier2").local
            case .III: return Strings("tier3").local
            }
        }
        
        var damageFraction: Double {
            return self.rawValue
        }
    }
    
    public let tier: Tier
    private let duration = 3
    
    init(tier: Tier, amount: Int) {
        self.tier = tier
        
        super.init(
            name: Strings("consumable.damageBuffAll.name").local.continuedBy(tier.string),
            description: Strings("consumable.damageBuffAll.description").local,
            effectsDescription: Strings("consumable.damageBuffAll.effectsDescription2Param").localWithArgs(tier.damageFraction.toRelativePercentage(), String(self.duration)),
            requiresFoeForUsage: true,
            remainingUses: amount
        )
    }
    
    required init(_ original: ConsumableAbstract) {
        let original = original as! Self
        self.tier = original.tier
        super.init(original)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract?) {
        guard let opposition else {
            assertionFailure("Consumable that requires an opposition is being used without one")
            return
        }
        let buff = DamagePercentBuff(sourceName: self.name, direction: .outgoing, duration: self.duration, damageFraction: self.tier.damageFraction)
        owner.addBuff(buff)
        opposition.addBuff(buff)
        self.adjustRemainingUses(by: -1)
    }
    
    func isStackable(with consumable: Consumable) -> Bool {
        if let consumable = consumable as? Self {
            return consumable.tier == self.tier
        }
        return false
    }
    
    func calculateBasePurchasePrice() -> Int {
        return 80
    }
    
}
