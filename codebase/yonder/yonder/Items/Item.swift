//
//  Item.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class ItemAbstract {
    
    var damage: Int = 0
    var healthRestoration: Int = 0
    var remainingUses: Int = 0
    public let id = UUID().uuidString
    
    func getAppliedDamage(owner: ActorAbstract, target: ActorAbstract) -> Int {
        var appliedDamage = self.damage
        for buff in owner.getAllBuffsInPriority() {
            if buff.type == .damage {
                appliedDamage = buff.applyDamage(to: appliedDamage)!
            }
        }
        for buff in target.getAllBuffsInPriority() {
            if buff.type == .damage {
                appliedDamage = buff.applyDamage(to: appliedDamage)!
            }
        }
        return appliedDamage
    }
    
    func getAppliedHealthRestoration(owner: ActorAbstract, target: ActorAbstract) -> Int {
        var appliedHealthRestoration = self.healthRestoration
        for buff in owner.getAllBuffsInPriority() {
            if buff.type == .health {
                appliedHealthRestoration = buff.applyHealth(to: appliedHealthRestoration)!
            }
        }
        for buff in target.getAllBuffsInPriority() {
            if buff.type == .health {
                appliedHealthRestoration = buff.applyHealth(to: appliedHealthRestoration)!
            }
        }
        return appliedHealthRestoration
    }
    
}
