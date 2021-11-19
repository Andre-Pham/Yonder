//
//  Foe.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class FoeAbstract: ActorAbstract {
    
    init(maxHealth: Int, weapon: WeaponAbstract) {
        super.init(maxHealth: maxHealth)
        
        self.addWeapon(weapon)
    }
    
    func getWeapon() -> WeaponAbstract {
        return self.weapons.first!
    }
    
}
