//
//  OnGoldChange.swift
//  yonder
//
//  Created by Andre Pham on 18/9/2022.
//

import Foundation

class OnGoldChangePublisher {
    
    static private var subscribers = [WeakOnGoldChangeSubscriber]()
    
    static func subscribe(_ subscriber: OnGoldChangeSubscriber) {
        self.subscribers.append(WeakOnGoldChangeSubscriber(value: subscriber))
    }
    
    static func publish(player: Player) {
        for sub in Self.subscribers {
            sub.value?.onGoldChange(player: player)
        }
    }
    
}


protocol OnGoldChangeSubscriber: AnyObject {
    
    func onGoldChange(player: Player)
    
}


private class WeakOnGoldChangeSubscriber {
    
    private(set) weak var value: OnGoldChangeSubscriber?

    init(value: OnGoldChangeSubscriber?) {
        self.value = value
    }
    
}
