//
//  CombatFlow.swift
//  yonder
//
//  Created by Andre Pham on 13/2/2022.
//

import Foundation

class CombatFlow {
    
    private(set) var turnsTaken = 0
    
    func completeTurn(player: Player, foe: Foe) {
        foe.attack(player)
        for act in [player, foe] {
            act.triggerStatusEffects()
            act.decrementTimedEvents()
        }
        
        self.turnsTaken += 1
    }
    
}
