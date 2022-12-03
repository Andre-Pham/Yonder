//
//  BurnStatusEffect.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class BurnStatusEffect: StatusEffect {
    
    private let damage: Int
    
    init(damage: Int, duration: Int) {
        self.damage = damage
        super.init(name: Strings("statusEffect.burn.name").local, duration: duration)
    }
    
    required init(_ original: StatusEffectAbstract) {
        let original = original as! Self
        self.damage = original.damage
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case damage
    }

    required init(dataObject: DataObject) {
        self.damage = dataObject.get(Field.damage.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.damage.rawValue, value: self.damage)
    }

    // MARK: - Functions
    
    func getEffectsDescription() -> String? {
        return Strings("statusEffect.burn.effectsDescription1Param").localWithArgs(self.damage)
    }
    
    func applyEffect(actor: ActorAbstract) {
        actor.damageAdjusted(sourceOwner: NoActor(), using: self, for: self.damage)
    }
    
    func getIndicativeValue(target: ActorAbstract) -> Int? {
        return BuffApps.getAppliedDamage(owner: NoActor(), using: self, target: target, damage: self.damage)
    }
    
}
