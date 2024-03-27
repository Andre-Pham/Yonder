//
//  AfterGameLoaded.swift
//  yonder
//
//  Created by Andre Pham on 27/3/2024.
//

import Foundation

/// Triggers after a game is loaded - regardless of whether it was a game newly created, or if it is being resumed from a save file.
class AfterGameLoadedPublisher {
    
    static private var subscribers = [WeakAfterGameLoadedSubscriber]()
    
    static func subscribe(_ subscriber: AfterGameLoadedSubscriber) {
        self.subscribers.append(WeakAfterGameLoadedSubscriber(value: subscriber))
    }
    
    static func publish(game: Game) {
        for sub in Self.subscribers {
            sub.value?.afterGameLoaded(game: game)
        }
    }
    
}


protocol AfterGameLoadedSubscriber: AnyObject {
    
    func afterGameLoaded(game: Game)
    
}


private class WeakAfterGameLoadedSubscriber {
    
    private(set) weak var value: AfterGameLoadedSubscriber?

    init(value: AfterGameLoadedSubscriber?) {
        self.value = value
    }
    
}
