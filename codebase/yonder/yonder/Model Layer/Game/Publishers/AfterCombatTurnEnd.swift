//
//  AfterCombatTurnEnd.swift
//  yonder
//
//  Created by Andre Pham on 17/11/2022.
//

import Foundation

class AfterCombatTurnEndPublisher {
    
    static private var subscribers = [WeakAfterCombatTurnEndSubscriber]()
    
    static func subscribe(_ subscriber: AfterCombatTurnEndSubscriber) {
        self.subscribers.append(WeakAfterCombatTurnEndSubscriber(value: subscriber))
    }
    
    static func publish(player: Player, playerUsed item: Item, foe: Foe) {
        for sub in Self.subscribers {
            sub.value?.afterCombatTurnEnd(player: player, playerUsed: item, foe: foe)
        }
    }
    
}


protocol AfterCombatTurnEndSubscriber: AnyObject {
    
    func afterCombatTurnEnd(player: Player, playerUsed: Item, foe: Foe)
    
}


private class WeakAfterCombatTurnEndSubscriber {
    
    private(set) weak var value: AfterCombatTurnEndSubscriber?

    init(value: AfterCombatTurnEndSubscriber?) {
        self.value = value
    }
    
}
