//
//  WeaponEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

/// Pill that provides the weapon with additional effects, such as providing buffs.
typealias WeaponEffectPill = WeaponEffectPillAbstract & WeaponEffectPillProtocol

protocol WeaponEffectPillProtocol {
    
    var effectsDescription: String { get }
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract)
    func getValue() -> Int
    
}

class WeaponEffectPillAbstract: Clonable {
    
    public let id = UUID()
    
    init() { }
    required init(_ original: WeaponEffectPillAbstract) { }
    
}
