//
//  PermanentBuffConsumable.swift
//  yonder
//
//  Created by Andre Pham on 6/3/2024.
//

import Foundation

/// Gives the user a buff. Typically should be used in contexts where the buff is permanent (lasts forever).
class BuffConsumable: Consumable {
    
    private let buff: Buff
    
    init(buff: Buff, amount: Int) {
        self.buff = buff.clone()
        
        super.init(
            name: Strings("consumable.buff.name").local,
            description: "",
            effectsDescription: buff.getEffectsDescription(),
            remainingUses: amount
        )
    }
    
    required init(_ original: ConsumableAbstract) {
        let original = original as! Self
        self.buff = original.buff.clone()
        super.init(original)
    }
    
    // MARK: - Serialisation
    
    private enum Field: String {
        case buff
    }
    
    required init(dataObject: DataObject) {
        self.buff = dataObject.getObject(Field.buff.rawValue, type: BuffAbstract.self) as! any Buff
        super.init(dataObject: dataObject)
    }
    
    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.buff.rawValue, value: self.buff)
    }
    
    // MARK: - Functions
    
    func use(owner: ActorAbstract, opposition: ActorAbstract?) {
        owner.addBuff(self.buff)
        self.adjustRemainingUses(by: -1)
    }
    
    func isStackable(with consumable: Consumable) -> Bool {
        // We're not going to deal with stacking this type of consumable
        // Maybe in the future we can deal with the concept of which buffs can stack
        return false
    }
    
    func calculateBasePurchasePrice() -> Int {
        return self.buff.getValue(whenTargeting: .player)
    }
    
}
