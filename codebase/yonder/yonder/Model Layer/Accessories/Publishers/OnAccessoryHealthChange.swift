//
//  OnAccessoryHealthChange.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import Foundation

class OnAccessoryHealthChangePublisher {
    
    static private var subscribers = [WeakOnAccessoryHealthChangeSubscriber]()
    
    static func subscribe(_ subscriber: OnAccessoryHealthChangeSubscriber) {
        self.subscribers.append(WeakOnAccessoryHealthChangeSubscriber(value: subscriber))
    }
    
    static func publish(accessory: Accessory, change: Int) {
        for sub in Self.subscribers {
            sub.value?.onAccessoryHealthChange(accessory: accessory, change: change)
        }
    }
    
}


protocol OnAccessoryHealthChangeSubscriber: AnyObject {
    
    func onAccessoryHealthChange(accessory: Accessory, change: Int)
    
}


private class WeakOnAccessoryHealthChangeSubscriber {
    
    private(set) weak var value: OnAccessoryHealthChangeSubscriber?

    init(value: OnAccessoryHealthChangeSubscriber?) {
        self.value = value
    }
    
}
