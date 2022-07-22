//
//  DelayedDamageValues.swift
//  yonder
//
//  Created by Andre Pham on 22/7/2022.
//

import Foundation

class DelayedDamageValues {
    
    enum DamageType {
        case regular
        case armor
        case health
    }
    
    typealias DamageValue = (damage: Int, applyBuffs: Bool, source: Any?, sourceOwner: ActorAbstract, type: DamageType)
    
    private var values = [DamageValue]()
    
    func addDamageAdjusted(sourceOwner: ActorAbstract, using source: Any, for damage: Int, type: DamageType = .regular) {
        self.values.append(DamageValue(damage: damage, applyBuffs: true, source: source, sourceOwner: sourceOwner, type: type))
    }
    
    func addDamage(damage: Int, type: DamageType = .regular) {
        self.values.append(DamageValue(damage: damage, applyBuffs: false, source: nil, sourceOwner: NoActor(), type: type))
    }
    
    func consume(by actor: ActorAbstract) {
        for value in self.values {
            if value.applyBuffs {
                switch value.type {
                case .regular:
                    actor.damageAdjusted(sourceOwner: value.sourceOwner, using: value.source!, for: value.damage)
                case .armor:
                    actor.damageArmorPointsAdjusted(sourceOwner: value.sourceOwner, using: value.source!, for: value.damage)
                case .health:
                    actor.damageHealthAdjusted(sourceOwner: value.sourceOwner, using: value.source!, for: value.damage)
                }
            } else {
                switch value.type {
                case .regular:
                    actor.damage(for: value.damage)
                case .armor:
                    actor.damageArmorPoints(for: value.damage)
                case .health:
                    actor.damageHealth(for: value.damage)
                }
            }
        }
        self.values.removeAll()
    }
    
}
