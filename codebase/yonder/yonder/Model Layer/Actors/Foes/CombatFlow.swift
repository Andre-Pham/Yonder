//
//  CombatFlow.swift
//  yonder
//
//  Created by Andre Pham on 13/2/2022.
//

import Foundation

class CombatFlow {
    
    private(set) var turnsTaken = 0
    
    func completeTurn(player: Player, playerUsed playerItem: ItemAbstract, foe: Foe) {
        foe.attack(player)
        
        OnTurnEndPublisher.publish(player: player, playerUsed: playerItem, foe: foe)
        
        for act in [player, foe] {
            act.onTurnCompletion()
        }
        if foe.isDead {
            player.clearAttributes()
        }
        
        self.turnsTaken += 1
        
        AfterTurnEndPublisher.publish(player: player, playerUsed: playerItem, foe: foe)
    }
    
}
