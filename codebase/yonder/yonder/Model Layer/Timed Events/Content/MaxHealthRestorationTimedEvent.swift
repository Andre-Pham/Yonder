//
//  MaxHealthRestorationTimedEvent.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class MaxHealthRestorationTimedEvent: TimedEvent {
    
    public let timer: Timer
    
    init(timeToTrigger: Int) {
        self.timer = Timer(startTime: timeToTrigger)
        super.init(name: Strings("timedEvent.maxHealthRestoration.name").local)
    }
    
    required init(_ original: TimedEventAbstract) {
        let original = original as! Self
        self.timer = original.timer.clone()
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case timer
    }

    required init(dataObject: DataObject) {
        self.timer = dataObject.getObject(Field.timer.rawValue, type: Timer.self)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.timer.rawValue, value: self.timer)
    }

    // MARK: - Functions
    
    func triggerEvent(target: ActorAbstract) {
        target.restoreHealth(for: target.maxHealth)
    }
    
    func getIndicativeValue(target: ActorAbstract) -> Int? {
        return nil
    }
    
    func getEffectsDescription() -> String? {
        return Strings("timedEvent.maxHealthRestoration.effectsDescription").local
    }
    
}
