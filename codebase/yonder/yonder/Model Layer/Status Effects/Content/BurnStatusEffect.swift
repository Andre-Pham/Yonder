//
//  BurnStatusEffect.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class BurnStatusEffect: StatusEffectAbstract {
    
    private let damage: Int
    
    init(damage: Int, duration: Int) {
        self.damage = damage
        super.init(name: Strings.StatusEffect.Burn.Name.local, duration: duration)
    }
    
    required init(_ original: StatusEffectPart) {
        let original = original as! Self
        self.damage = original.damage
        super.init(original)
    }
    
    func getEffectsDescription() -> String? {
        return Strings.StatusEffect.Burn.EffectsDescription1Param.localWithArgs(self.damage)
    }
    
    func applyEffect(actor: ActorAbstract) {
        actor.damageAdjusted(sourceOwner: NoActor(), using: self, for: self.damage)
    }
    
    func getIndicativeValue(target: ActorAbstract) -> Int? {
        return BuffApps.getAppliedDamage(owner: NoActor(), using: self, target: target, damage: self.damage)
    }
    
}
