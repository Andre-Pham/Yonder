//
//  BonusHealthConsumable.swift
//  yonder
//
//  Created by Andre Pham on 7/9/2022.
//

import Foundation

/// Gives the user permanent bonus health.
class BonusHealthConsumable: Consumable {
    
    enum Tier: Int, CaseIterable {
        case I = 1
        case II = 2
        case III = 3
        case IV = 4
        
        var amount: Int {
            switch self {
            case .I:
                return 25
            case .II:
                return 50
            case .III:
                return 80
            case .IV:
                return 150
            }
        }
    }
    
    public let tier: Tier
    
    init(tier: Tier, amount: Int) {
        self.tier = tier
        
        var name: String
        var description: String
        switch tier {
        case .I:
            name = Strings("consumable.adjustMaxHealth.name.tier1").local
            description = Strings("consumable.adjustMaxHealth.description.tier1").local
        case .II:
            name = Strings("consumable.adjustMaxHealth.name.tier2").local
            description = Strings("consumable.adjustMaxHealth.description.tier2").local
        case .III:
            name = Strings("consumable.adjustMaxHealth.name.tier3").local
            description = Strings("consumable.adjustMaxHealth.description.tier3").local
        case .IV:
            name = Strings("consumable.adjustMaxHealth.name.tier4").local
            description = Strings("consumable.adjustMaxHealth.description.tier4").local
        }
        super.init(
            name: name,
            description: description,
            effectsDescription: Strings("consumable.adjustMaxHealth.effectsDescription1Param").localWithArgs(tier.amount),
            remainingUses: amount
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
        owner.adjustBonusHealth(by: self.tier.amount)
        self.adjustRemainingUses(by: -1)
    }
    
    func isStackable(with consumable: Consumable) -> Bool {
        if let consumable = consumable as? Self {
            return consumable.tier == self.tier
        }
        return false
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerPermanentHealthStat.getValue(amount: self.tier.amount, uses: self.remainingUses)
    }
    
}
