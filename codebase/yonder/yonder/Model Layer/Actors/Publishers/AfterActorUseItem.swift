//
//  AfterActorUseItem.swift
//  yonder
//
//  Created by Andre Pham on 10/12/2022.
//

import Foundation

class AfterActorUseItemPublisher {
    
    static private var subscribers = [WeakAfterActorUseItemSubscriber]()
    
    static func subscribe(_ subscriber: AfterActorUseItemSubscriber) {
        self.subscribers.append(WeakAfterActorUseItemSubscriber(value: subscriber))
    }
    
    static func publish(actor: ActorAbstract, item: Item, opposition: ActorAbstract?) {
        for sub in Self.subscribers {
            sub.value?.afterActorUseItem(actor: actor, item: item, opposition: opposition)
        }
    }
    
}


protocol AfterActorUseItemSubscriber: AnyObject {
    
    func afterActorUseItem(actor: ActorAbstract, item: Item, opposition: ActorAbstract?)
    
}


private class WeakAfterActorUseItemSubscriber {
    
    private(set) weak var value: AfterActorUseItemSubscriber?

    init(value: AfterActorUseItemSubscriber?) {
        self.value = value
    }
    
}
