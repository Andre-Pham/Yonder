//
//  OnNoPotionsRemaining.swift
//  yonder
//
//  Created by Andre Pham on 27/8/2022.
//

import Foundation

class OnNoPotionsRemainingPublisher {
    
    static private var subscribers = [WeakOnNoPotionsRemainingSubscriber]()
    
    static func subscribe(_ subscriber: OnNoPotionsRemainingSubscriber) {
        self.subscribers.append(WeakOnNoPotionsRemainingSubscriber(value: subscriber))
    }
    
    static func publish(potion: PotionAbstract) {
        for sub in Self.subscribers {
            sub.value?.onNoPotionsRemaining(potion: potion)
        }
    }
    
}


protocol OnNoPotionsRemainingSubscriber: AnyObject {
    
    func onNoPotionsRemaining(potion: PotionAbstract)
    
}


private class WeakOnNoPotionsRemainingSubscriber {
    
    private(set) weak var value: OnNoPotionsRemainingSubscriber?

    init(value: OnNoPotionsRemainingSubscriber?) {
        self.value = value
    }
    
}
