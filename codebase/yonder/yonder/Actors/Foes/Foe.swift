//
//  Foe.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class FoeAbstract: ActorAbstract, Named, Described {
    
    public let name: String
    public let description: String
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", maxHealth: Int, weapon: WeaponAbstract) {
        self.name = name
        self.description = description
        
        super.init(maxHealth: maxHealth)
        
        self.addWeapon(weapon)
    }
    
    func getWeapon() -> WeaponAbstract {
        return self.weapons.first!
    }
    
}
