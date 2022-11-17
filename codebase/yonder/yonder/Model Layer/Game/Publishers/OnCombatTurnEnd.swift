//
//  OnCombatTurnEnd.swift
//  yonder
//
//  Created by Andre Pham on 17/11/2022.
//

import Foundation

class OnCombatTurnEndPublisher {
    
    static private var subscribers = [WeakOnCombatTurnEndSubscriber]()
    
    static func subscribe(_ subscriber: OnCombatTurnEndSubscriber) {
        self.subscribers.append(WeakOnCombatTurnEndSubscriber(value: subscriber))
    }
    
    static func publish(player: Player, playerUsed item: Item, foe: Foe) {
        for sub in Self.subscribers {
            sub.value?.onCombatTurnEnd(player: player, playerUsed: item, foe: foe)
        }
    }
    
}


protocol OnCombatTurnEndSubscriber: AnyObject {
    
    func onCombatTurnEnd(player: Player, playerUsed: Item, foe: Foe)
    
}


private class WeakOnCombatTurnEndSubscriber {
    
    private(set) weak var value: OnCombatTurnEndSubscriber?

    init(value: OnCombatTurnEndSubscriber?) {
        self.value = value
    }
    
}
