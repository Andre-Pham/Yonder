//
//  AfterTurnEnd.swift
//  yonder
//
//  Created by Andre Pham on 28/8/2022.
//

import Foundation

/// Triggers after the end of every turn (including when there is no foe)
class AfterTurnEndPublisher {
    
    static private var subscribers = [WeakAfterTurnEndSubscriber]()
    
    static func subscribe(_ subscriber: AfterTurnEndSubscriber) {
        self.subscribers.append(WeakAfterTurnEndSubscriber(value: subscriber))
    }
    
    static func publish(player: Player, playerUsed item: Item?, foe: Foe?) {
        for sub in Self.subscribers {
            sub.value?.afterTurnEnd(player: player, playerUsed: item, foe: foe)
        }
    }
    
}


protocol AfterTurnEndSubscriber: AnyObject {
    
    func afterTurnEnd(player: Player, playerUsed: Item?, foe: Foe?)
    
}


private class WeakAfterTurnEndSubscriber {
    
    private(set) weak var value: AfterTurnEndSubscriber?

    init(value: AfterTurnEndSubscriber?) {
        self.value = value
    }
    
}
