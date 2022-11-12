//
//  AfterStageChange.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class AfterStageChangePublisher {
    
    static private var subscribers = [WeakAfterStageChangeSubscriber]()
    
    static func subscribe(_ subscriber: AfterStageChangeSubscriber) {
        self.subscribers.append(WeakAfterStageChangeSubscriber(value: subscriber))
    }
    
    static func publish(newStage: Int) {
        for sub in Self.subscribers {
            sub.value?.afterStageChange(newStage: newStage)
        }
    }
    
}


protocol AfterStageChangeSubscriber: AnyObject {
    
    func afterStageChange(newStage: Int)
    
}


private class WeakAfterStageChangeSubscriber {
    
    private(set) weak var value: AfterStageChangeSubscriber?

    init(value: AfterStageChangeSubscriber?) {
        self.value = value
    }
    
}
