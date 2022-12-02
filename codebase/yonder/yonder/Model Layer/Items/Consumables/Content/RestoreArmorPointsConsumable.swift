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
    enum Tier: Int, CaseIterable {
        case I = 1
        case II = 2
        case III = 3
        case IV = 4
        case V = 5
        
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
            switch self {
            case .I: return 25
            case .II: return 50
            case .III: return 100
            case .IV: return 200
            case .V: return 400
            }
        }
    }
    
    public let tier: Tier
    
    init(tier: Tier, amount: Int) {
        self.tier = tier
        
        super.init(
            name: Strings("consumable.restoreArmorPoints.name").local.continuedBy(tier.string),
            description: Strings("consumable.restoreArmorPoints.description").local,
            effectsDescription: Strings("consumable.restoreArmorPoints.effectsDescription1Param").localWithArgs(tier.armorPointsRestoration),
            remainingUses: amount,
            armorPointsRestoration: self.tier.armorPointsRestoration
        )
    }
    
    required init(_ original: ConsumableAbstract) {
        let original = original as! Self
        self.tier = original.tier
        super.init(original)
    }
    
    // MARK: - Serialisation
    
    private enum Field: String {
        case tier
    }
    
    required init(dataObject: DataObject) {
        self.tier = Tier(rawValue: dataObject.get(Field.tier.rawValue)) ?? .I
        super.init(dataObject: dataObject)
    }
    
    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.tier.rawValue, value: self.tier.rawValue)
    }
    
    // MARK: - Functions
    
    func use(owner: ActorAbstract, opposition: ActorAbstract?) {
        owner.restoreArmorPointsAdjusted(sourceOwner: owner, using: self, for: self.armorPointsRestoration)
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
