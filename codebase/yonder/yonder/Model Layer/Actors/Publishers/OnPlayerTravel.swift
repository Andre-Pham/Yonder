//
//  OnPlayerTravel.swift
//  yonder
//
//  Created by Andre Pham on 9/9/2022.
//

import Foundation

class OnPlayerTravelPublisher {
    
    static private var subscribers = [WeakOnPlayerTravelSubscriber]()
    
    static func subscribe(_ subscriber: OnPlayerTravelSubscriber) {
        self.subscribers.append(WeakOnPlayerTravelSubscriber(value: subscriber))
    }
    
    static func publish(player: Player, newLocation: LocationAbstract) {
        for sub in Self.subscribers {
            sub.value?.onPlayerTravel(player: player, newLocation: newLocation)
        }
    }
    
}


protocol OnPlayerTravelSubscriber: AnyObject {
    
    func onPlayerTravel(player: Player, newLocation: LocationAbstract)
    
}


private class WeakOnPlayerTravelSubscriber {
    
    private(set) weak var value: OnPlayerTravelSubscriber?

    init(value: OnPlayerTravelSubscriber?) {
        self.value = value
    }
    
}
