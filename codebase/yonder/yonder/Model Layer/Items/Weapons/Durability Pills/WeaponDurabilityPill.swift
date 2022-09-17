//
//  WeaponDurabilityPill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

/// Pill that sets how the weapon loses remaining uses (i.e. durability) over time.
/// Weapons can only take one of this pill.
typealias WeaponDurabilityPill = WeaponDurabilityPillAbstract & WeaponDurabilityPillProtocol

protocol WeaponDurabilityPillProtocol {
    
    var effectsDescription: String { get }
    
    func use(on weapon: Weapon)
    func getValue() -> Int
    func setupDurability(weapon: Weapon)
    
}

class WeaponDurabilityPillAbstract: Clonable {
    
    public let id = UUID()
    
    init() { }
    required init(_ original: WeaponDurabilityPillAbstract) { }
    
}
