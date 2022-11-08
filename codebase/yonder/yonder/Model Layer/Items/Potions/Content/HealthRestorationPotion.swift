//
//  HealthRestorationPotion.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class HealthRestorationPotion: Potion {
    
    /// The tier of the health potion. Greater tiers restore greater health.
    /// Raw value represents the amount of health restoration of each tier.
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
        
        var healthRestoration: Int {
            return self.rawValue
        }
    }
    
    init(tier: Tier, potionCount: Int) {
        super.init(
            name: Strings("potion.healthRestoration.name").local.continuedBy(tier.string),
            description: Strings("potion.healthRestoration.description").local,
            effectsDescription: Strings("potion.healthRestoration.effectsDescription1Param").localWithArgs(tier.healthRestoration),
            remainingUses: potionCount,
            healthRestoration: tier.healthRestoration)
    }
    
    required init(_ original: PotionAbstract) {
        super.init(original)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract) {
        owner.restoreHealthAdjusted(sourceOwner: owner, using: self, for: self.healthRestoration)
        self.adjustRemainingUses(by: -1)
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerHealthRestorationStat.getValue(amount: self.healthRestoration, uses: self.remainingUses)
    }
    
}
