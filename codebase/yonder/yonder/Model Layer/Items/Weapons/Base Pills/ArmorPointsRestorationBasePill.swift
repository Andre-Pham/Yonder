//
//  ArmorPointsRestorationBasePill.swift
//  yonder
//
//  Created by Andre Pham on 25/6/2022.
//

import Foundation

class ArmorPointsRestorationBasePill: WeaponBasePill {
    
    private(set) var armorPointsRestoration: Int
    public let effectsDescription: String? = nil
    
    init(armorPointsRestoration: Int) {
        self.armorPointsRestoration = armorPointsRestoration
    }
    
    func setup(weapon: Weapon) {
        weapon.setArmorPointsRestoration(to: self.armorPointsRestoration)
    }
    
    func getValue() -> Int {
        return self.armorPointsRestoration
    }
    
}
