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
class StableGameStateManager: Storable, AfterTurnEndSubscriber, AfterActorUseItemSubscriber {
    
    private var lastKilledFoeID: UUID? = nil
    
    init() {
        AfterTurnEndPublisher.subscribe(self)
        AfterActorUseItemPublisher.subscribe(self)
    }
    
    // MARK: - Serialisation
    
    private enum Field: String {
        case lastKilledFoeID
    }

    required init(dataObject: DataObject) {
        let uuidString: String? = dataObject.get(Field.lastKilledFoeID.rawValue)
        self.lastKilledFoeID = (uuidString == nil) ? nil : UUID(uuidString: uuidString!)
        
        AfterTurnEndPublisher.subscribe(self)
        AfterActorUseItemPublisher.subscribe(self)
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.lastKilledFoeID.rawValue, value: self.lastKilledFoeID?.uuidString)
    }
    
    // MARK: - Functions
    
    private func stableStateReached(player: Player, item: Item?, foe: Foe?) {
        if let foe, foe.isDead, foe.id != self.lastKilledFoeID {
            // We assume the player killed the foe since foes don't kill themself
            AfterPlayerKillFoePublisher.publish(player: player, foe: foe)
            // We assume there's no world where a player kills a foe, kills another foe, then returns to the previous dead foe
            // Otherwise some sort of death register dictionary would have to be implemented
            self.lastKilledFoeID = foe.id
        }
        if player.isDead {
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
