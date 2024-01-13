//
//  OnCombatTurnStart.swift
//  yonder
//
//  Created by Andre Pham on 17/11/2022.
//

import Foundation

/// Triggers on the start of every new turn during combat (doesn't trigger in locations with no foe)
class OnCombatTurnStartPublisher {
    
    static private var subscribers = [WeakOnCombatTurnStartSubscriber]()
    
    static func subscribe(_ subscriber: OnCombatTurnStartSubscriber) {
        self.subscribers.append(WeakOnCombatTurnStartSubscriber(value: subscriber))
    }
    
    static func publish(player: Player, playerUsed item: Item, foe: Foe) {
        for sub in Self.subscribers {
            sub.value?.onCombatTurnStart(player: player, playerUsed: item, foe: foe)
        }
    }
    
}


protocol OnCombatTurnStartSubscriber: AnyObject {
    
    func onCombatTurnStart(player: Player, playerUsed: Item, foe: Foe)
    
}


private class WeakOnCombatTurnStartSubscriber {
    
    private(set) weak var value: OnCombatTurnStartSubscriber?

    init(value: OnCombatTurnStartSubscriber?) {
        self.value = value
    }
    
}
