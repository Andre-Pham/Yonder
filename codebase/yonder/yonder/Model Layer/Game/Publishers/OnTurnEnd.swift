//
//  OnTurnEnd.swift
//  yonder
//
//  Created by Andre Pham on 28/8/2022.
//

import Foundation

/// Triggers on the end of every turn (including when there is no foe)
class OnTurnEndPublisher {
    
    static private var subscribers = [WeakOnTurnEndSubscriber]()
    
    static func subscribe(_ subscriber: OnTurnEndSubscriber) {
        self.subscribers.append(WeakOnTurnEndSubscriber(value: subscriber))
    }
    
    static func publish(player: Player, playerUsed item: Item?, foe: Foe?) {
        for sub in Self.subscribers {
            sub.value?.onTurnEnd(player: player, playerUsed: item, foe: foe)
        }
    }
    
}


protocol OnTurnEndSubscriber: AnyObject {
    
    func onTurnEnd(player: Player, playerUsed: Item?, foe: Foe?)
    
}


private class WeakOnTurnEndSubscriber {
    
    private(set) weak var value: OnTurnEndSubscriber?

    init(value: OnTurnEndSubscriber?) {
        self.value = value
    }
    
}
