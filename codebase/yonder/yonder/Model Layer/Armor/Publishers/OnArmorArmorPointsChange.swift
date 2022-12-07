//
//  OnArmorArmorPointsChange.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import Foundation

class OnArmorArmorPointsChangePublisher {
    
    static private var subscribers = [WeakOnArmorArmorPointsChangeSubscriber]()
    
    static func subscribe(_ subscriber: OnArmorArmorPointsChangeSubscriber) {
        self.subscribers.append(WeakOnArmorArmorPointsChangeSubscriber(value: subscriber))
    }
    
    static func publish(armor: Armor, change: Int) {
        for sub in Self.subscribers {
            sub.value?.onArmorArmorPointsChange(armor: armor, change: change)
        }
    }
    
}


protocol OnArmorArmorPointsChangeSubscriber: AnyObject {
    
    func onArmorArmorPointsChange(armor: Armor, change: Int)
    
}


private class WeakOnArmorArmorPointsChangeSubscriber {
    
    private(set) weak var value: OnArmorArmorPointsChangeSubscriber?

    init(value: OnArmorArmorPointsChangeSubscriber?) {
        self.value = value
    }
    
}
