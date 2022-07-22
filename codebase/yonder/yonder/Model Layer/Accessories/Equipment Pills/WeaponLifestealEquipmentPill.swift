//
//  WeaponLifestealEquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 22/7/2022.
//

import Foundation

class WeaponLifestealEquipmentPill: EquipmentPillAbstract, AfterActorAttackSubscriber {
    
    private let lifestealFraction: Double
    
    init(lifestealFraction: Double) {
        self.lifestealFraction = lifestealFraction
        super.init(effectsDescription: Strings.EquipmentPill.WeaponLifesteal.EffectsDescription1Param.localWithArgs((lifestealFraction*100.0).toString()))
        
        ActorPublisher.addSubscriber(self)
    }
    
    required init(_ original: EquipmentPillAbstractPart) {
        let original = original as! Self
        self.lifestealFraction = original.lifestealFraction
        super.init(effectsDescription: original.effectsDescription)
        
        ActorPublisher.addSubscriber(self)
    }
    
    func afterActorAttack(actor: ActorAbstract, weapon: Weapon, target: ActorAbstract) {
        guard actor.accessorySlots.hasEffect(self) else {
            return
        }
        let damageDealt = actor.getIndicativeDamage(of: weapon, opposition: target)
        let healthToRestore = Int(round(Double(damageDealt)*self.lifestealFraction))
        actor.delayedRestorationValues.addRestorationAdjusted(type: .health, sourceOwner: actor, using: self, for: healthToRestore)
    }
    
    func getValue() -> Int {
        return Int(round(self.lifestealFraction*10.0))
    }
    
}
