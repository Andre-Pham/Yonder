//
//  Foe.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class FoeAbstract: ActorAbstract {
    
    private(set) var attackDamage: Int
    
    init(maxHealth: Int, attackDamage: Int) {
        self.attackDamage = attackDamage
        
        super.init(maxHealth: maxHealth)
    }
    
    func attackPlayer() {
        GAME.player.damage(for: self.attackDamage)
    }
    
}
