//
//  Foe.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class Foe: ActorAbstract, Named, Described {
    
    public let name: String
    public let description: String
    private let combatFlow = CombatFlow()
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", maxHealth: Int, weapon: Weapon) {
        self.name = name
        self.description = description
        
        super.init(maxHealth: maxHealth)
        
        self.addWeapon(weapon)
    }
    
    func getWeapon() -> Weapon {
        return self.weapons.first!
    }
    
    func attack(_ player: Player) {
        self.useWeaponOn(target: player, weapon: self.getWeapon())
    }
    
    func completeTurn(player: Player) {
        self.combatFlow.completeTurn(player: player, foe: self)
    }
    
}
