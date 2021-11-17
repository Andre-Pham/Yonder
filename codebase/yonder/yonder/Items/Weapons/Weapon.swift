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
    var appliedDamage: Int = 0
    var durability: Int = 0
    
    func setAppliedDamage(to damage: Int) {
        self.appliedDamage = damage
    }
    
}
