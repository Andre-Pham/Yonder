//
//  TurnManager.swift
//  yonder
//
//  Created by Andre Pham on 9/9/2022.
//

import Foundation

/// Manages triggers that need to be activated at the end of each turn.
/// Subscribes to certain events to detect when an end of turn should be triggered. If in the future other events trigger an end of turn, add this as a subscriber for those events.
class TurnManager: AfterActorUseItemSubscriber, AfterPlayerTravelSubscriber {
    
    init() {
        AfterPlayerTravelPublisher.subscribe(self)
        AfterActorUseItemPublisher.subscribe(self)
    }
    
    func afterActorUseItem(actor: ActorAbstract, item: Item, opposition: ActorAbstract?) {
        if item.triggersEndOfTurn, let player = actor as? Player, let foe = opposition as? Foe {
            foe.attack(player)
            self.completeTurn(player: player, playerUsed: item, foe: foe)
            self.startTurn(player: player, playerUsed: item, foe: foe)
        }
    }
    
    func afterPlayerTravel(player: Player) {
        self.completeTurn(player: player)
        self.startTurn(player: player)
    }
    
    /// Completes a turn after the player uses an item.
    /// To only be used publicly for testing by manually triggering end of turn effects. Otherwise, treat this as a private function.
    /// - Parameters:
    ///   - player: The player ending their turn
    ///   - playerItem: The item the player used
    ///   - foe: The foe that was present during the item's use
    func completeTurn(player: Player, playerUsed playerItem: Item, foe: Foe) {
        OnCombatTurnEndPublisher.publish(player: player, playerUsed: playerItem, foe: foe)
        OnTurnEndPublisher.publish(player: player, playerUsed: playerItem, foe: foe)
        
        for act in [player, foe] {
            self.triggerEndTurnActorEffects(on: act)
        }
        if foe.isDead {
            player.clearAttributes()
        }
        
        AfterCombatTurnEndPublisher.publish(player: player, playerUsed: playerItem, foe: foe)
        AfterTurnEndPublisher.publish(player: player, playerUsed: playerItem, foe: foe)
    }
    
    /// Completes a turn.
    /// To only be used publicly for testing by manually triggering end of turn effects. Otherwise, treat this as a private function.
    /// - Parameters:
    ///   - player: The player ending their turn
    func completeTurn(player: Player) {
        OnTurnEndPublisher.publish(player: player, playerUsed: nil, foe: nil)
        
        self.triggerEndTurnActorEffects(on: player)
        
        AfterTurnEndPublisher.publish(player: player, playerUsed: nil, foe: nil)
    }
    
    func startTurn(player: Player, playerUsed playerItem: Item, foe: Foe) {
        OnTurnStartPublisher.publish(player: player, foe: foe)
        OnCombatTurnStartPublisher.publish(player: player, playerUsed: playerItem, foe: foe)
    }
    
    func startTurn(player: Player) {
        OnTurnStartPublisher.publish(player: player, foe: nil)
    }
    
    private func triggerEndTurnActorEffects(on actor: ActorAbstract) {
        actor.delayedDamageValues.consume(by: actor)
        actor.delayedRestorationValues.consume(by: actor)
        actor.triggerStatusEffects()
        actor.decrementTimedEvents()
        actor.decrementBuffs()
    }
    
}
