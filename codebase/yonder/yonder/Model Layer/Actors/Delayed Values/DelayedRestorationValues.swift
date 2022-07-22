//
//  DelayedRestorationValues.swift
//  yonder
//
//  Created by Andre Pham on 22/7/2022.
//

import Foundation

class DelayedRestorationValues {
    
    enum RestorationType {
        case health
        case armorPoints
        case overflow
    }
    
    typealias RestorationValue = (amount: Int, applyBuffs: Bool, source: Any?, sourceOwner: ActorAbstract, type: RestorationType)
    
    private var values = [RestorationValue]()
    
    func addRestoration(type: RestorationType, amount: Int) {
        self.values.append(RestorationValue(amount: amount, applyBuffs: false, source: nil, sourceOwner: NoActor(), type: type))
    }
    
    func addRestorationAdjusted(type: RestorationType, sourceOwner: ActorAbstract, using source: Any, for amount: Int) {
        self.values.append(RestorationValue(amount: amount, applyBuffs: true, source: source, sourceOwner: sourceOwner, type: type))
    }
    
    func consume(by actor: ActorAbstract) {
        for value in self.values {
            if value.applyBuffs {
                switch value.type {
                case .health:
                    actor.restoreHealthAdjusted(sourceOwner: value.sourceOwner, using: value.source!, for: value.amount)
                case .armorPoints:
                    actor.restoreArmorPointsAdjusted(sourceOwner: value.sourceOwner, using: value.source!, for: value.amount)
                case .overflow:
                    actor.restoreAdjusted(sourceOwner: value.sourceOwner, using: value.source!, for: value.amount)
                }
            } else {
                switch value.type {
                case .health:
                    actor.restoreHealth(for: value.amount)
                case .armorPoints:
                    actor.restoreArmorPoints(for: value.amount)
                case .overflow:
                    actor.restore(for: value.amount)
                }
            }
        }
        self.values.removeAll()
    }
    
}
