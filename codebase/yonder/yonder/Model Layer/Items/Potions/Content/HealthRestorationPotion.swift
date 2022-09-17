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
        
        var healthRestoration: Int {
            return self.rawValue
        }
    }
    
    init(tier: Tier, potionCount: Int, basePurchasePrice: Int) {
        super.init(
            name: Strings.Potion.HealthRestoration.Name.local.continuedBy(tier.string),
            description: Strings.Potion.HealthRestoration.Description.local,
            effectsDescription: Strings.Potion.HealthRestoration.EffectsDescription1Param.localWithArgs(tier.healthRestoration),
            remainingUses: potionCount,
            healthRestoration: tier.healthRestoration,
            basePurchasePrice: basePurchasePrice)
    }
    
    required init(_ original: PotionAbstract) {
        super.init(original)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract) {
        owner.restoreHealthAdjusted(sourceOwner: owner, using: self, for: self.healthRestoration)
        self.adjustRemainingUses(by: -1)
    }
    
}
