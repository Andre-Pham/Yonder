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
    public let loot: LootOptions
    var canBeLooted: Bool {
        return self.isDead && !self.loot.isLooted
    }
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", maxHealth: Int, weapon: Weapon, loot: LootOptions) {
        self.name = name
        self.description = description
        self.loot = loot
        
        super.init(maxHealth: maxHealth)
        
        self.addWeapon(weapon)
    }
    
    func getWeapon() -> Weapon {
        assert(self.weapons.count == 1, "Foe has more or less than 1 weapon, which shouldn't be possible")
        return self.weapons.first!
    }
    
    func attack(_ player: Player) {
        self.useWeaponWhere(opposition: player, weapon: self.getWeapon())
    }
    
}
