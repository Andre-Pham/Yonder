//
//  WeaponPillBox.swift
//  yonder
//
//  Created by Andre Pham on 18/9/2022.
//

import Foundation

/// This stores weak references of all weapon and pill relationships. This means that pills can access their parent weapon without holding their reference.
/// Pills can't hold weapon references without creating a circular dependency, hence this class' existence. If they were to hold a weapon instance, cloning a weapon would clone their pills which would reclone the weapon causing an infinite loop.
class WeaponPillBox {
    
    private static var durabilityPills = [UUID: WeakWeapon]()
    private static var effectPills = [UUID: WeakWeapon]()
    private static var buffPills = [UUID: WeakWeapon]()
    
    static func setDurabilityPills(weapon: Weapon) {
        Self.durabilityPills[weapon.durabilityPill.id] = WeakWeapon(weapon)
    }
    
    static func setEffectPills(weapon: Weapon) {
        for effectPill in weapon.effectPills {
            Self.effectPills[effectPill.id] = WeakWeapon(weapon)
        }
    }
    
    static func setBuffPills(weapon: Weapon) {
        for buffPill in weapon.buffPills {
            Self.buffPills[buffPill.id] = WeakWeapon(weapon)
        }
    }
    
    static func getWeapon(from durabilityPill: WeaponDurabilityPill) -> Weapon? {
        return Self.durabilityPills[durabilityPill.id]?.value
    }
    
    static func getWeapon(from effectPill: WeaponEffectPill) -> Weapon? {
        return Self.effectPills[effectPill.id]?.value
    }
    
    static func getWeapon(from buffPill: WeaponBuffPill) -> Weapon? {
        return Self.buffPills[buffPill.id]?.value
    }
    
}

private class WeakWeapon {
    
    weak var value: Weapon?
    
    init(_ weapon: Weapon) {
        self.value = weapon
    }
    
}
