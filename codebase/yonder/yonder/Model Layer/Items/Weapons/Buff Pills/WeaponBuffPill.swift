//
//  WeaponBuffPill.swift
//  yonder
//
//  Created by Andre Pham on 19/9/2022.
//

import Foundation

/// Pill that affects the behaviour of one of a weapon's base stats (damage, restoration, healthRestoration, armorPointsRestoration)
typealias WeaponBuffPill = WeaponBuffPillAbstract & WeaponBuffPillProtocol

protocol WeaponBuffPillProtocol: HasPurchasablePrice {
    
    var effectsDescription: String { get }
    
}

class WeaponBuffPillAbstract: Clonable {
    
    public let id = UUID()
    
    init() { }
    required init(_ original: WeaponBuffPillAbstract) { }
    
    func applyDamage(weapon: Weapon, owner: ActorAbstract, opposition: ActorAbstract) -> Int {
        return weapon.damage
    }
    
    func applyRestoration(weapon: Weapon, owner: ActorAbstract, opposition: ActorAbstract) -> Int {
        return weapon.restoration
    }
    
    func applyHealthRestoration(weapon: Weapon, owner: ActorAbstract, opposition: ActorAbstract) -> Int {
        return weapon.healthRestoration
    }
    
    func applyArmorPointsRestoration(weapon: Weapon, owner: ActorAbstract, opposition: ActorAbstract) -> Int {
        return weapon.armorPointsRestoration
    }
    
}
