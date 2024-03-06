//
//  MultiplyGoldConsumable.swift
//  yonder
//
//  Created by Andre Pham on 7/9/2022.
//

import Foundation

class MultiplyGoldConsumable: Consumable {
    
    private let goldFraction: Double
    
    init(goldFraction: Double, amount: Int) {
        self.goldFraction = goldFraction
        
        let percentage = self.goldFraction.toRelativePercentage(decimalPlaces: 0)
        super.init(
            name: Strings("consumable.multiplyGold.name").local,
            description: Strings("consumable.multiplyGold.description").local,
            effectsDescription: Strings("consumable.multiplyGold.effectsDescription1Param").localWithArgs(percentage),
            remainingUses: amount
        )
    }
    
    required init(_ original: ConsumableAbstract) {
        let original = original as! Self
        self.goldFraction = original.goldFraction
        super.init(original)
    }
    
    // MARK: - Serialisation
    
    private enum Field: String {
        case goldFraction
    }
    
    required init(dataObject: DataObject) {
        self.goldFraction = dataObject.get(Field.goldFraction.rawValue)
        super.init(dataObject: dataObject)
    }
    
    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.goldFraction.rawValue, value: self.goldFraction)
    }
    
    // MARK: - Functions
    
    func use(owner: ActorAbstract, opposition: ActorAbstract?) {
        if let player = owner as? Player {
            player.modifyGoldAdjusted(by: Int(round(Double(player.gold)*abs(1.0 - self.goldFraction))))
            self.adjustRemainingUses(by: -1)
        }
    }
    
    func isStackable(with consumable: Consumable) -> Bool {
        if let consumable = consumable as? Self {
            return isEqual(self.goldFraction, consumable.goldFraction)
        }
        return false
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerGoldStat.getValue(
            amount: (Double(Pricing.playerGoldStat.baseStatAmount)*abs(1.0 - self.goldFraction)).toRoundedInt(),
            uses: self.remainingUses
        )
    }
    
}
