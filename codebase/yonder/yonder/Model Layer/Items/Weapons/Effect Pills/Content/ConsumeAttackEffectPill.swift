//
//  ConsumeAttackEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 23/11/2022.
//

import Foundation

/// Whenever this weapon kills a foe, this weapon adds that foe's damage.
class ConsumeAttackEffectPill: WeaponEffectPill, AfterTurnEndSubscriber {
    
    public let effectsDescription: String
    
    override init() {
        self.effectsDescription = Strings("weaponEffectPill.consumeAttack.description").local
        super.init()
        
        AfterTurnEndPublisher.subscribe(self)
    }
    
    required init(_ original: WeaponEffectPillAbstract) {
        let original = original as! Self
        self.effectsDescription = original.effectsDescription
        super.init(original)
        
        AfterTurnEndPublisher.subscribe(self)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case effectsDescription
    }

    required init(dataObject: DataObject) {
        self.effectsDescription = dataObject.get(Field.effectsDescription.rawValue)
        super.init(dataObject: dataObject)
        
        AfterTurnEndPublisher.subscribe(self)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.effectsDescription.rawValue, value: self.effectsDescription)
    }

    // MARK: - Functions
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract) {
        // No nothing
    }
    
    func afterTurnEnd(player: Player, playerUsed: Item?, foe: Foe?) {
        if let weapon = playerUsed as? Weapon, let foe = foe {
            if weapon.damage > 0 && weapon.hasEffectPill(self) && foe.isDead {
                weapon.setDamage(to: foe.getWeapon().damage)
            }
        }
    }
    
    func calculateBasePurchasePrice() -> Int {
        return 40
    }
    
}
