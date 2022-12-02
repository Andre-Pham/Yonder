//
//  DamagePercentBuffPotion.swift
//  yonder
//
//  Created by Andre Pham on 24/6/2022.
//

import Foundation

class DamagePercentBuffPotion: Potion {
    
    /// The tier of the damage percent potion.
    enum Tier: Int, CaseIterable {
        case I = 1
        case II = 2
        case III = 3
        
        var string: String {
            switch self {
            case .I: return Strings("tier1").local
            case .II: return Strings("tier2").local
            case .III: return Strings("tier3").local
            }
        }
        
        var damageFraction: Double {
            switch self {
            case .I: return 1.2
            case .II: return 1.5
            case .III: return 2.0
            }
        }
    }
    
    private let buff: DamagePercentBuff
    
    /// To determine if potion is stackable
    private let duration: Int
    private let tier: Tier
    
    init(tier: Tier, duration: Int, potionCount: Int) {
        let name = Strings("potion.damagePercent.name").local.continuedBy(tier.string)
        self.buff = DamagePercentBuff(sourceName: name, direction: .outgoing, duration: duration, damageFraction: tier.damageFraction)
        self.duration = duration
        self.tier = tier
        super.init(
            name: name,
            description: Strings("potion.damagePercent.description").local,
            effectsDescription: Strings("potion.applyToSelf").local.continuedBy(self.buff.getEffectsDescription() ?? ""),
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
    
    // MARK: - Serialisation
        
    private enum Field: String {
        case buff
        case duration
        case tier
    }
    
    required init(dataObject: DataObject) {
        self.buff = dataObject.getObject(Field.buff.rawValue, type: DamagePercentBuff.self)
        self.duration = dataObject.get(Field.duration.rawValue)
        self.tier = Tier(rawValue: dataObject.get(Field.tier.rawValue)) ?? .I
        super.init(dataObject: dataObject)
    }
    
    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.buff.rawValue, value: self.buff)
            .add(key: Field.duration.rawValue, value: self.duration)
            .add(key: Field.tier.rawValue, value: self.tier.rawValue)
    }
    
    // MARK: - Functions
    
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
