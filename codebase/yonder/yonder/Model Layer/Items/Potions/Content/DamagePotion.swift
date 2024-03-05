//
//  DamagePotion.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class DamagePotion: Potion {
    
    /// The tier of the damage potion. Greater tiers deal greater damage.
    enum Tier: CaseIterable {
        case I
        case II
        case III
        case IV
        case V
        
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
            switch self {
            case .I: return 20
            case .II: return 30
            case .III: return 50
            case .IV: return 80
            case .V: return 130
            }
        }
    }
    
    init(tier: Tier, potionCount: Int) {
        super.init(
            name: Strings("potion.damage.name").local.continuedBy(tier.string),
            description: Strings("potion.damage.description").local,
            effectsDescription: nil,
            remainingUses: potionCount,
            damage: tier.damage,
            requiresFoeForUsage: true
        )
    }
    
    required init(_ original: PotionAbstract) {
        super.init(original)
    }
    
    // MARK: - Serialisation
    
    required init(dataObject: DataObject) {
        super.init(dataObject: dataObject)
    }
    
    override func toDataObject() -> DataObject {
        return super.toDataObject()
    }
    
    // MARK: - Functions
    
    func use(owner: ActorAbstract, opposition: ActorAbstract?) {
        assert(opposition != nil, "Potion requires a foe but none was provided")
        opposition?.damageAdjusted(sourceOwner: owner, using: self, for: self.damage)
        self.adjustRemainingUses(by: -1)
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerDamageStat.getValue(amount: self.damage, uses: self.remainingUses)
    }
    
}
