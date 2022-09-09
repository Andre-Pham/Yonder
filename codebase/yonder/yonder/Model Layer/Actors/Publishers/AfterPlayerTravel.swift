//
//  AfterPlayerTravel.swift
//  yonder
//
//  Created by Andre Pham on 9/9/2022.
//

import Foundation

class AfterPlayerTravelPublisher {
    
    static private var subscribers = [WeakAfterPlayerTravelSubscriber]()
    
    static func subscribe(_ subscriber: AfterPlayerTravelSubscriber) {
        self.subscribers.append(WeakAfterPlayerTravelSubscriber(value: subscriber))
    }
    
    static func publish(player: Player) {
        for sub in Self.subscribers {
            sub.value?.AfterPlayerTravel(player: player)
        }
    }
    
}


protocol AfterPlayerTravelSubscriber: AnyObject {
    
    func AfterPlayerTravel(player: Player)
    
}


private class WeakAfterPlayerTravelSubscriber {
    
    private(set) weak var value: AfterPlayerTravelSubscriber?

    init(value: AfterPlayerTravelSubscriber?) {
        self.value = value
    }
    
}
