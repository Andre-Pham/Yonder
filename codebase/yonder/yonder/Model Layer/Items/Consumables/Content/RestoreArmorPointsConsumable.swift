//
//  RestoreArmorPointsConsumable.swift
//  yonder
//
//  Created by Andre Pham on 22/9/2022.
//

import Foundation

/// Restore armor points.
class RestoreArmorPointsConsumable: Consumable {
    
    /// The tier of the consumable. Greater tiers restore more armor points.
    /// Raw value represents the armor points restoration of each tier.
    enum Tier: Int {
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
        
        var armorPointsRestoration: Int {
            return self.rawValue
        }
    }
    
    public let tier: Tier
    
    init(tier: Tier) {
        self.tier = tier
        
        super.init(
            name: Strings("consumable.restoreArmorPoints.name").local.continuedBy(tier.string),
            description: Strings("consumable.restoreArmorPoints.description").local,
            effectsDescription: Strings("consumable.restoreArmorPoints.effectsDescription1Param").localWithArgs(tier.armorPointsRestoration),
            armorPointsRestoration: self.tier.armorPointsRestoration
        )
    }
    
    required init(_ original: ConsumableAbstract) {
        let original = original as! Self
        self.tier = original.tier
        super.init(original)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract?) {
        self.adjustRemainingUses(by: -1)
    }
    
    func isStackable(with consumable: Consumable) -> Bool {
        if let consumable = consumable as? Self {
            return consumable.tier == self.tier
        }
        return false
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerArmorPointsRestorationStat.getValue(amount: self.armorPointsRestoration, uses: self.remainingUses)
    }
    
}
