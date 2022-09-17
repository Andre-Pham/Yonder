//
//  DamagePercentPotion.swift
//  yonder
//
//  Created by Andre Pham on 24/6/2022.
//

import Foundation

class DamagePercentPotion: PotionAbstract {
    
    /// The tier of the damage percent potion.
    /// Raw value represents the damage fraction of each tier.
    enum Tier: Double {
        case I = 1.2
        case II = 1.5
        case III = 2.0
        
        var string: String {
            switch self {
            case .I: return Strings.Potion.Tier1.local
            case .II: return Strings.Potion.Tier2.local
            case .III: return Strings.Potion.Tier3.local
            }
        }
        
        var damageFraction: Double {
            return self.rawValue
        }
    }
    
    private let buff: DamagePercentBuff
    
    init(tier: Tier, duration: Int, potionCount: Int, basePurchasePrice: Int) {
        let name = Strings.Potion.DamagePercent.Name.local.continuedBy(tier.string)
        self.buff = DamagePercentBuff(sourceName: name, direction: .outgoing, duration: duration, damageFraction: tier.damageFraction)
        super.init(
            name: name,
            description: Strings.Potion.DamagePercent.Description.local,
            effectsDescription: self.buff.getEffectsDescription(),
            remainingUses: potionCount,
            basePurchasePrice: basePurchasePrice)
    }
    
    required init(_ original: PotionAbstractPart) {
        let original = original as! Self
        self.buff = original.buff.clone()
        super.init(original)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract) {
        owner.addBuff(self.buff)
        self.adjustRemainingUses(by: -1)
    }
    
}
