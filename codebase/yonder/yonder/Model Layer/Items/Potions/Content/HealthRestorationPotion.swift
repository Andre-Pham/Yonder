//
//  HealthRestorationPotion.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class HealthRestorationPotion: Potion {
    
    /// The tier of the health potion. Greater tiers restore greater health.
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
        
        var healthRestoration: Int {
            switch self {
            case .I: return 25
            case .II: return 50
            case .III: return 100
            case .IV: return 200
            case .V: return 400
            }
        }
    }
    
    init(tier: Tier, potionCount: Int) {
        super.init(
            name: Strings("potion.healthRestoration.name").local.continuedBy(tier.string),
            description: Strings("potion.healthRestoration.description").local,
            effectsDescription: nil,
            remainingUses: potionCount,
            healthRestoration: tier.healthRestoration,
            requiresFoeForUsage: false
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
        owner.restoreHealthAdjusted(sourceOwner: owner, using: self, for: self.healthRestoration)
        self.adjustRemainingUses(by: -1)
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerHealthRestorationStat.getValue(amount: self.healthRestoration, uses: self.remainingUses)
    }
    
}
