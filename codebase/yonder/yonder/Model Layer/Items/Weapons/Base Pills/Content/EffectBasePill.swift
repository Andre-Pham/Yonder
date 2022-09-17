//
//  EffectBasePill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

class EffectBasePill: WeaponBasePill {
    
    public let effectsDescription: String? = nil
    
    override init() {
        // This is required to provide an empty initialiser
        super.init()
    }
    
    required init(_ original: WeaponBasePillAbstract) {
        super.init(original)
    }
    
    func setup(weapon: Weapon) {
        // Nothing to setup
    }
    
    func getValue() -> Int {
        return 0
    }
    
}
