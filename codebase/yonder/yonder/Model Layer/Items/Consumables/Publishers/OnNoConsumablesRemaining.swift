//
//  OnNoConsumablesRemaining.swift
//  yonder
//
//  Created by Andre Pham on 7/9/2022.
//

import Foundation

class OnNoConsumablesRemainingPublisher {
    
    static private var subscribers = [WeakOnNoConsumablesRemainingSubscriber]()
    
    static func subscribe(_ subscriber: OnNoConsumablesRemainingSubscriber) {
        self.subscribers.append(WeakOnNoConsumablesRemainingSubscriber(value: subscriber))
    }
    
    static func publish(consumable: Consumable) {
        for sub in Self.subscribers {
            sub.value?.onNoConsumablesRemaining(consumable: consumable)
        }
    }
    
}


protocol OnNoConsumablesRemainingSubscriber: AnyObject {
    
    func onNoConsumablesRemaining(consumable: Consumable)
    
}


private class WeakOnNoConsumablesRemainingSubscriber {
    
    private(set) weak var value: OnNoConsumablesRemainingSubscriber?

    init(value: OnNoConsumablesRemainingSubscriber?) {
        self.value = value
    }
    
}
