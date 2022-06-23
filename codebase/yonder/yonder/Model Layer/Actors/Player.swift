//
//  Player.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class Player: ActorAbstract {
    
    @DidSetPublished private(set) var location: LocationAbstract
    @DidSetPublished private(set) var gold = 0
    private(set) var attributes = [PlayerAttribute]()
    
    init(maxHealth: Int, location: LocationAbstract) {
        self.location = location
        location.setToVisited(from: NoLocation())
        
        super.init(maxHealth: maxHealth)
    }
    
    func modifyGold(by amount: Int) {
        self.gold += amount
    }
    
    func modifyGoldAdjusted(by amount: Int) {
        if amount < 0 {
            self.modifyGold(by: BuffApps.getAdjustedPrice(purchaser: self, price: amount))
        }
        else if amount > 0 {
            self.modifyGold(by: BuffApps.getAdjustedGoldWithBonus(receiver: self, gold: amount))
        }
    }
    
    func travel(to location: LocationAbstract) {
        location.setToVisited(from: self.location)
        self.location = location
    }
    
    func clearAttributes() {
        self.attributes.removeAll()
    }
    
    func addAttribute(_ attribute: PlayerAttribute) {
        self.attributes.append(attribute)
    }
    
    /// Retrieves the weapons the player can actually attack with.
    /// Provides the player with a default weapon if they are out of weapons or banned from attacking with weapons so the game can't reach a stalemate.
    /// - Returns: Weapons the player is permitted to attack with
    func getApplicableWeapons() -> [Weapon] {
        if self.weapons.isEmpty || self.attributes.contains(.cantAttack) {
            return [DefaultPlayerWeapon()]
        }
        return Array(self.weapons)
    }
    
}
