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
        for buff in owner.getAllBuffsInPriority() {
            if buff.type == .damage {
                appliedDamage = buff.applyDamage(to: appliedDamage)!
            }
        }
        for buff in target.getAllBuffsInPriority() {
            if buff.type == .resistance {
                appliedDamage = buff.applyResistance(to: appliedDamage)!
            }
        }
        return appliedDamage
    }
    
}
