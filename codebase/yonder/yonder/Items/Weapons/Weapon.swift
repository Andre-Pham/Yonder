//
//  Weapon.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

typealias WeaponAbstract = WeaponAbstractPart & Usable

class WeaponAbstractPart {
    
    var damage: Int = 0
    var durability: Int = 0
    
    func getAppliedDamage(owner: ActorAbstract, target: ActorAbstract) -> Int {
        var appliedDamage = self.damage
        owner.orderBuffsInPriority()
        for buff in owner.buffs {
            if buff.type == .damage {
                appliedDamage = buff.applyDamage(to: appliedDamage)!
            }
        }
        target.orderBuffsInPriority()
        for buff in target.buffs {
            if buff.type == .resistance {
                appliedDamage = buff.applyResistance(to: appliedDamage)!
            }
        }
        return appliedDamage
    }
    
}
