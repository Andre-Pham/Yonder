//
//  OnActorUseItem.swift
//  yonder
//
//  Created by Andre Pham on 10/12/2022.
//

import Foundation

class OnActorUseItemPublisher {
    
    static private var subscribers = [WeakOnActorUseItemSubscriber]()
    
    static func subscribe(_ subscriber: OnActorUseItemSubscriber) {
        self.subscribers.append(WeakOnActorUseItemSubscriber(value: subscriber))
    }
    
    static func publish(actor: ActorAbstract, item: Item, opposition: ActorAbstract?) {
        for sub in Self.subscribers {
            sub.value?.onActorUseItem(actor: actor, item: item, opposition: opposition)
        }
    }
    
}


protocol OnActorUseItemSubscriber: AnyObject {
    
    func onActorUseItem(actor: ActorAbstract, item: Item, opposition: ActorAbstract?)
    
}


private class WeakOnActorUseItemSubscriber {
    
    private(set) weak var value: OnActorUseItemSubscriber?

    init(value: OnActorUseItemSubscriber?) {
        self.value = value
    }
    
}
