//
//  OnAccessoryArmorPointsChange.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import Foundation

class OnAccessoryArmorPointsChangePublisher {
    
    static private var subscribers = [WeakOnAccessoryArmorPointsChangeSubscriber]()
    
    static func subscribe(_ subscriber: OnAccessoryArmorPointsChangeSubscriber) {
        self.subscribers.append(WeakOnAccessoryArmorPointsChangeSubscriber(value: subscriber))
    }
    
    static func publish(accessory: Accessory, change: Int) {
        for sub in Self.subscribers {
            sub.value?.onAccessoryArmorPointsChange(accessory: accessory, change: change)
        }
    }
    
}


protocol OnAccessoryArmorPointsChangeSubscriber: AnyObject {
    
    func onAccessoryArmorPointsChange(accessory: Accessory, change: Int)
    
}


private class WeakOnAccessoryArmorPointsChangeSubscriber {
    
    private(set) weak var value: OnAccessoryArmorPointsChangeSubscriber?

    init(value: OnAccessoryArmorPointsChangeSubscriber?) {
        self.value = value
    }
    
}
