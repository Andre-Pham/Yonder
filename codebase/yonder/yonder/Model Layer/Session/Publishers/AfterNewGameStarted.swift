//
//  AfterNewGameStarted.swift
//  yonder
//
//  Created by Andre Pham on 27/3/2024.
//

import Foundation

/// Triggers after a new game is started.
class AfterNewGameStartedPublisher {
    
    static private var subscribers = [WeakAfterNewGameStartedSubscriber]()
    
    static func subscribe(_ subscriber: AfterNewGameStartedSubscriber) {
        self.subscribers.append(WeakAfterNewGameStartedSubscriber(value: subscriber))
    }
    
    static func publish(game: Game) {
        for sub in Self.subscribers {
            sub.value?.afterNewGameStarted(game: game)
        }
    }
    
}


protocol AfterNewGameStartedSubscriber: AnyObject {
    
    func afterNewGameStarted(game: Game)
    
}


private class WeakAfterNewGameStartedSubscriber {
    
    private(set) weak var value: AfterNewGameStartedSubscriber?

    init(value: AfterNewGameStartedSubscriber?) {
        self.value = value
    }
    
}
