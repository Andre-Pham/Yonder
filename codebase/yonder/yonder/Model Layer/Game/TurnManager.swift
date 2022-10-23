//
//  TurnManager.swift
//  yonder
//
//  Created by Andre Pham on 9/9/2022.
//

import Foundation

/// Manages triggers that need to be activated at the end of each turn.
/// Subscribes to certain events to detect when an end of turn should be triggered. If in the future other events trigger an end of turn, add this as a subscriber for those events.
class TurnManager: AfterActorAttackSubscriber, AfterPlayerTravelSubscriber {
    
    private(set) var turnsTaken = 0
    
    init() {
        AfterPlayerTravelPublisher.subscribe(self)
        AfterActorAttackPublisher.subscribe(self)
    }
    
    func afterActorAttack(actor: ActorAbstract, weapon: Weapon, target: ActorAbstract) {
        if let player = actor as? Player, let foe = target as? Foe {
            foe.attack(player)
            self.completeTurn(player: player, playerUsed: weapon, foe: foe)
        }
    }
    
    func afterPlayerTravel(player: Player) {
        self.completeTurn(player: player)
    }
    
    /// Completes a turn after the player uses an item.
    /// To only be used publicly for testing by manually triggering end of turn effects. Otherwise, treat this as a private function.
    /// - Parameters:
    ///   - player: The player ending their turn
    ///   - playerItem: The item the player used
    ///   - foe: The foe that was present during the item's use
    func completeTurn(player: Player, playerUsed playerItem: Item, foe: Foe) {
        OnTurnEndPublisher.publish(player: player, playerUsed: playerItem, foe: foe)
        
        for act in [player, foe] {
            self.triggerEndTurnActorEffects(on: act)
        }
        if foe.isDead {
            player.clearAttributes()
        }
        self.turnsTaken += 1
        
        AfterTurnEndPublisher.publish(player: player, playerUsed: playerItem, foe: foe)
    }
    
    /// Completes a turn.
    /// To only be used publicly for testing by manually triggering end of turn effects. Otherwise, treat this as a private function.
    /// - Parameters:
    ///   - player: The player ending their turn
    func completeTurn(player: Player) {
        OnTurnEndPublisher.publish(player: player, playerUsed: nil, foe: nil)
        
        self.triggerEndTurnActorEffects(on: player)
        self.turnsTaken += 1
        
        AfterTurnEndPublisher.publish(player: player, playerUsed: nil, foe: nil)
    }
    
    private func triggerEndTurnActorEffects(on actor: ActorAbstract) {
        actor.delayedDamageValues.consume(by: actor)
        actor.delayedRestorationValues.consume(by: actor)
        actor.triggerStatusEffects()
        actor.decrementTimedEvents()
        actor.decrementBuffs()
    }
    
}

/// A singleton instance of `TurnManager` used for testing.
/// The scope at which instances are created and stored varies between testing scopes. This means that depending on the scope of tests run, multiple copies of `TurnManager` is created. The only simple approach to solving this is using a singleton specifically for testing.
class TestsTurnManager {
    
    static let turnManager = TurnManager()
    
}
