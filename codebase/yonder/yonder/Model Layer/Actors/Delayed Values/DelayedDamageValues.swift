//
//  DelayedDamageValues.swift
//  yonder
//
//  Created by Andre Pham on 22/7/2022.
//

import Foundation

/// Holds damage values to be applied (consumed) to an actor later, rather than immediately.
/// Applying damage values later rather than immediately allows the handling of "simultaneous" actions. If a hostile attacks a player for 100, and the player heals for 100, these actions would be expected to occur simultaneously, so the player's health has no change. By using delayed values, we can ensure that any damage is consumed before any healing so that simultaneous actions result in the expected outcome.
/// This also allows for values to be calculated after an action. For example, consider a weapon lifesteal accessory. You need to get the damage the weapon will do before it attacks, but restore health after attacks have been completed. By delaying the damage and health restoration, you can calculate the weapon's damage before attacking whilst only applying the health restoration after the player has taken damage.
class DelayedDamageValues {
    
    enum DamageType {
        case regular
        case armor
        case health
    }
    
    typealias DamageValue = (damage: Int, type: DamageType)
    
    private var values = [DamageValue]()
    
    func addDamageAdjusted(sourceOwner: ActorAbstract, using source: Any, target: ActorAbstract, for damage: Int, type: DamageType = .regular) {
        let damage = BuffApps.getAppliedDamage(owner: sourceOwner, using: source, target: target, damage: damage)
        self.values.append(DamageValue(damage: damage, type: type))
    }
    
    func addDamage(damage: Int, type: DamageType = .regular) {
        self.values.append(DamageValue(damage: damage, type: type))
    }
    
    func consume(by actor: ActorAbstract) {
        for value in self.values {
            switch value.type {
            case .regular:
                actor.damage(for: value.damage)
            case .armor:
                actor.damageArmorPoints(for: value.damage)
            case .health:
                actor.damageHealth(for: value.damage)
            }
        }
        self.values.removeAll()
    }
    
}
