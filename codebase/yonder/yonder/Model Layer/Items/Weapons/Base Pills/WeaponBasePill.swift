//
//  WeaponBasePill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

/// Pill that initialises weapon properties, for example providing a healing value.
/// Weapons can only take one of this pill.
typealias WeaponBasePill = WeaponBasePillAbstract & WeaponBasePillProtocol

protocol WeaponBasePillProtocol: HasPurchasablePrice {
    
    var effectsDescription: String? { get }
    
    func setup(weapon: Weapon)
    
}

class WeaponBasePillAbstract: Clonable {
    
    public let id = UUID()
    
    init() { }
    required init(_ original: WeaponBasePillAbstract) { }
    
}
