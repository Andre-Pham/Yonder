//
//  MultiplyArmorPointsConsumable.swift
//  yonder
//
//  Created by Andre Pham on 6/3/2024.
//

import Foundation

/// Multiplies armor points of every armor piece by a fraction upon use.
class MultiplyArmorPointsConsumable: Consumable {
    
    private let armorPointsFraction: Double
    
    init(armorPointsFraction: Double, amount: Int) {
        self.armorPointsFraction = armorPointsFraction
        
        let percentage = self.armorPointsFraction.toRelativePercentage(decimalPlaces: 0)
        super.init(
            name: Strings("consumable.multiplyArmorPoints.name").local,
            description: "",
            effectsDescription: Strings("consumable.multiplyArmorPoints.effectsDescription1Param").localWithArgs(percentage),
            remainingUses: amount
        )
    }
    
    required init(_ original: ConsumableAbstract) {
        let original = original as! Self
        self.armorPointsFraction = original.armorPointsFraction
        super.init(original)
    }
    
    // MARK: - Serialisation
    
    private enum Field: String {
        case armorPointsFraction
    }
    
    required init(dataObject: DataObject) {
        self.armorPointsFraction = dataObject.get(Field.armorPointsFraction.rawValue)
        super.init(dataObject: dataObject)
    }
    
    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.armorPointsFraction.rawValue, value: self.armorPointsFraction)
    }
    
    // MARK: - Functions
    
    func use(owner: ActorAbstract, opposition: ActorAbstract?) {
        if let player = owner as? Player {
            for armorPiece in player.allArmorPieces {
                armorPiece.adjustArmorPoints(by: (Double(armorPiece.armorPoints)*abs(1.0 - self.armorPointsFraction)).toRoundedInt())
            }
            self.adjustRemainingUses(by: -1)
        }
    }
    
    func isStackable(with consumable: Consumable) -> Bool {
        if let consumable = consumable as? Self {
            return isEqual(self.armorPointsFraction, consumable.armorPointsFraction)
        }
        return false
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerArmorPointsStat.getValue(
            amount: (Double(Pricing.playerArmorPointsStat.baseStatAmount)*abs(1.0 - self.armorPointsFraction)).toRoundedInt(),
            uses: self.remainingUses
        )
    }
    
}
