//
//  MultiplyHealthConsumable.swift
//  yonder
//
//  Created by Andre Pham on 6/3/2024.
//

import Foundation

class MultiplyHealthConsumable: Consumable {
    
    private let healthFraction: Double
    
    init(healthFraction: Double, amount: Int) {
        self.healthFraction = healthFraction
        
        let percentage = self.healthFraction.toRelativePercentage(decimalPlaces: 0)
        super.init(
            name: Strings("consumable.multiplyHealth.name").local,
            description: "",
            effectsDescription: Strings("consumable.multiplyHealth.effectsDescription1Param").localWithArgs(percentage),
            remainingUses: amount
        )
    }
    
    required init(_ original: ConsumableAbstract) {
        let original = original as! Self
        self.healthFraction = original.healthFraction
        super.init(original)
    }
    
    // MARK: - Serialisation
    
    private enum Field: String {
        case healthFraction
    }
    
    required init(dataObject: DataObject) {
        self.healthFraction = dataObject.get(Field.healthFraction.rawValue)
        super.init(dataObject: dataObject)
    }
    
    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.healthFraction.rawValue, value: self.healthFraction)
    }
    
    // MARK: - Functions
    
    func use(owner: ActorAbstract, opposition: ActorAbstract?) {
        if let player = owner as? Player {
            player.adjustBonusHealth(by: (Double(player.maxHealth)*abs(1.0 - self.healthFraction)).toRoundedInt())
            self.adjustRemainingUses(by: -1)
        }
    }
    
    func isStackable(with consumable: Consumable) -> Bool {
        if let consumable = consumable as? Self {
            return isEqual(self.healthFraction, consumable.healthFraction)
        }
        return false
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerPermanentHealthStat.getValue(
            amount: (Double(Pricing.playerPermanentHealthStat.baseStatAmount)*abs(1.0 - self.healthFraction)).toRoundedInt(),
            uses: self.remainingUses
        )
    }
    
}
