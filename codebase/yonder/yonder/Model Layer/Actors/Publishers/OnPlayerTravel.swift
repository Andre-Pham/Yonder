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
    
    static func publish(player: Player, newLocation: Location) {
        // We don't use a for loop because if new subscribers are added while this is being run they should also trigger
        var subIndex = 0
        while subIndex < Self.subscribers.count {
            Self.subscribers[subIndex].value?.onPlayerTravel(player: player, newLocation: newLocation)
            subIndex += 1
        }
    }
    
}


protocol OnPlayerTravelSubscriber: AnyObject {
    
    func onPlayerTravel(player: Player, newLocation: Location)
    
}


private class WeakOnPlayerTravelSubscriber {
    
    private(set) weak var value: OnPlayerTravelSubscriber?

    init(value: OnPlayerTravelSubscriber?) {
        self.value = value
    }
    
}
