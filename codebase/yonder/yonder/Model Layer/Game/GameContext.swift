//
//  GameContext.swift
//  yonder
//
//  Created by Andre Pham on 5/10/2022.
//

import Foundation

class GameContext: OnPlayerTravelSubscriber, AfterTurnEndSubscriber, AfterActorUseItemSubscriber {
    
    private(set) var stage: Int {
        didSet {
            AfterStageChangePublisher.publish(newStage: self.stage)
        }
    }
    private let map: Map
    
    init(map: Map, stage: Int = 0) {
        self.map = map
        self.stage = stage
        
        OnPlayerTravelPublisher.subscribe(self)
        AfterTurnEndPublisher.subscribe(self)
        AfterActorUseItemPublisher.subscribe(self)
    }
    
    func onPlayerTravel(player: Player, newLocation: Location) {
        let territory = self.map.territoriesInOrder[self.stage]
        if territory.tavernArea.tipLocations.contains(where: { $0.id == player.location.id }) && !territory.tavernArea.locations.contains(where: { $0.id == newLocation.id }) {
            // The player was at a tip location in the tavern area but now is no longer in the tavern area
            // Hence the player has exited the tavern area
            self.stage += 1
        }
    }
    
    // MARK: - Stable game states
    // These check for "stable states", where nothing is actively triggering
    // This is useful for tasks such as checking permanent death
    // Actors may be "dead" before they receive delayed restoration or equipment revives them
    // If an actor is dead in a stable state, they are for sure permanently dead
    
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
