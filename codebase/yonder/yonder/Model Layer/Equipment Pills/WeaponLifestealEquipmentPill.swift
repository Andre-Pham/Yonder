//
//  WeaponLifestealEquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 22/7/2022.
//

import Foundation

class WeaponLifestealEquipmentPill: EquipmentPillAbstract, OnActorAttackSubscriber {
    
    private let lifestealFraction: Double
    
    init(lifestealFraction: Double, sourceName: String) {
        self.lifestealFraction = lifestealFraction
        
        super.init(
            sourceName: sourceName,
            effectsDescription: Strings.EquipmentPill.WeaponLifesteal.EffectsDescription1Param
                .localWithArgs((lifestealFraction*100.0).toString())
        )
        
        OnActorAttackPublisher.subscribe(self)
    }
    
    required init(_ original: EquipmentPillAbstractPart) {
        let original = original as! Self
        self.lifestealFraction = original.lifestealFraction
        
        super.init(original)
        
        OnActorAttackPublisher.subscribe(self)
    }
    
    func onActorAttack(actor: ActorAbstract, weapon: Weapon, target: ActorAbstract) {
        guard actor.hasEquipmentEffect(self) else {
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
