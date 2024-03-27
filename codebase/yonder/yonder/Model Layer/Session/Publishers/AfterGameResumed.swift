//
//  AfterGameResumed.swift
//  yonder
//
//  Created by Andre Pham on 27/3/2024.
//

import Foundation

/// Triggers after a previously saved game is resumed.
class AfterGameResumedPublisher {
    
    static private var subscribers = [WeakAfterGameResumedSubscriber]()
    
    static func subscribe(_ subscriber: AfterGameResumedSubscriber) {
        self.subscribers.append(WeakAfterGameResumedSubscriber(value: subscriber))
    }
    
    static func publish(game: Game) {
        for sub in Self.subscribers {
            sub.value?.afterGameResumed(game: game)
        }
    }
    
}


protocol AfterGameResumedSubscriber: AnyObject {
    
    func afterGameResumed(game: Game)
    
}


private class WeakAfterGameResumedSubscriber {
    
    private(set) weak var value: AfterGameResumedSubscriber?

    init(value: AfterGameResumedSubscriber?) {
        self.value = value
    }
    
}
