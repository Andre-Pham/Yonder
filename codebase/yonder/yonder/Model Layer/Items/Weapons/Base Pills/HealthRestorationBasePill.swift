//
//  HealthRestorationBasePill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

class HealthRestorationBasePill: WeaponBasePill {
    
    private(set) var healthRestoration: Int
    
    init(healthRestoration: Int) {
        self.healthRestoration = healthRestoration
    }
    
    func setup(weapon: Weapon) {
        weapon.setHealthRestoration(to: self.healthRestoration)
    }
    
    func getValue() -> Int {
        return self.healthRestoration
    }
    
}
