//
//  HealthRestorationPercentBuffPotion.swift
//  yonder
//
//  Created by Andre Pham on 26/9/2022.
//

import Foundation

class HealthRestorationPercentBuffPotion: Potion {
    
    /// The tier of the health restoration percent potion.
    /// Raw value represents the health restoration fraction of each tier.
    enum Tier: Double {
        case I = 1.5
        case II = 2.0
        case III = 3.0
        
        var string: String {
            switch self {
            case .I: return Strings.Tier1.local
            case .II: return Strings.Tier2.local
            case .III: return Strings.Tier3.local
            }
        }
        
        var healthRestorationFraction: Double {
            return self.rawValue
        }
    }
    
    private let buff: HealthRestorationPercentBuff
    
    /// To determine if potion is stackable
    private let duration: Int
    private let tier: Tier
    
    init(tier: Tier, duration: Int, potionCount: Int) {
        let name = Strings.Potion.HealthRestorationPercent.Name.local.continuedBy(tier.string)
        self.buff = HealthRestorationPercentBuff(sourceName: name, direction: .incoming, duration: duration, healthFraction: tier.healthRestorationFraction)
        self.duration = duration
        self.tier = tier
        super.init(
            name: name,
            description: Strings.Potion.HealthRestoration.Description.local,
            effectsDescription: Strings.Potion.ApplyToSelf.local.continuedBy(self.buff.getEffectsDescription() ?? ""),
            remainingUses: potionCount)
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
        owner.addBuff(self.buff)
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
    
    func calculateBasePurchasePrice() -> Int {
        return self.remainingUses*self.buff.getValue(whenTargeting: .player)
    }
    
}
