//
//  AfterGameContextInit.swift
//  yonder
//
//  Created by Andre Pham on 13/1/2023.
//

import Foundation

class AfterGameContextInitPublisher {
    
    static private var subscribers = [WeakAfterGameContextInitSubscriber]()
    
    static func subscribe(_ subscriber: AfterGameContextInitSubscriber) {
        self.subscribers.append(WeakAfterGameContextInitSubscriber(value: subscriber))
    }
    
    static func publish(gameContext: GameContext) {
        for sub in Self.subscribers {
            sub.value?.afterGameContextInit(gameContext: gameContext)
        }
    }
    
}


protocol AfterGameContextInitSubscriber: AnyObject {
    
    func afterGameContextInit(gameContext: GameContext)
    
}


private class WeakAfterGameContextInitSubscriber {
    
    private(set) weak var value: AfterGameContextInitSubscriber?

    init(value: AfterGameContextInitSubscriber?) {
        self.value = value
    }
    
}

