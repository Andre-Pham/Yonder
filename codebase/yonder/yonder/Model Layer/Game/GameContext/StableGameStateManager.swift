//
//  StableGameStateManager.swift
//  yonder
//
//  Created by Andre Pham on 23/12/2022.
//

import Foundation

/// Manages stable game states.
/// Stable game states are states where nothing is actively triggering.
/// This is useful for tasks such as checking permanent death. Actors may be "dead" before they receive delayed restoration or equipment revives them. If an actor is dead in a stable state, they are for sure permanently dead.
class StableGameStateManager: AfterTurnEndSubscriber, AfterActorUseItemSubscriber {
    
    init() {
        AfterTurnEndPublisher.subscribe(self)
        AfterActorUseItemPublisher.subscribe(self)
    }
    
    private func stableStateReached(player: Player, item: Item?, foe: Foe?) {
        if let foe, foe.isDead {
            // We assume the player killed the foe since foes don't kill themself
            AfterPlayerKillFoePublisher.publish(player: player, foe: foe)
        } else if player.isDead {
            AfterPlayerDeathPublisher.publish(player: player)
        }
    }
    
    func afterTurnEnd(player: Player, playerUsed: Item?, foe: Foe?) {
        self.stableStateReached(player: player, item: playerUsed, foe: foe)
    }
    
    func afterActorUseItem(actor: ActorAbstract, item: Item, opposition: ActorAbstract?) {
        if !item.triggersEndOfTurn, let player = actor as? Player, let foe = opposition as? Foe {
            self.stableStateReached(player: player, item: item, foe: foe)
        }
    }
    
}
