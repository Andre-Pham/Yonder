//
//  BuffApplications.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

typealias BuffApps = BuffApplications
enum BuffApplications {
    
    static func getAppliedDamage(owner: ActorAbstract, using source: Any, target: ActorAbstract, damage: Int) -> Int {
        var appliedDamage = damage
        if owner.id == target.id {
            for buff in target.getAllBuffsInPriority() {
                if buff.type == .damage {
                    appliedDamage = buff.applyDamage(to: appliedDamage, source: source)!
                }
            }
        } else {
            // Owner buffs
            for buff in owner.getAllBuffsInPriority() {
                if buff.type == .damage && (buff.direction == .outgoing || buff.direction == .bidirectional) {
                    appliedDamage = buff.applyDamage(to: appliedDamage, source: source)!
                }
            }
            // Target buffs
            for buff in target.getAllBuffsInPriority() {
                if buff.type == .damage && (buff.direction == .incoming || buff.direction == .bidirectional) {
                    appliedDamage = buff.applyDamage(to: appliedDamage, source: source)!
                }
            }
        }
        return appliedDamage
    }
    
    static func getAppliedHealthRestoration(owner: ActorAbstract, using source: Any, target: ActorAbstract, healthRestoration: Int) -> Int {
        var appliedHealthRestoration = healthRestoration
        if owner.id == target.id {
            for buff in target.getAllBuffsInPriority() {
                if buff.type == .health {
                    appliedHealthRestoration = buff.applyHealth(to: appliedHealthRestoration, source: source)!
                }
            }
        } else {
            // Owner buffs
            for buff in owner.getAllBuffsInPriority() {
                if buff.type == .health && (buff.direction == .outgoing || buff.direction == .bidirectional) {
                    appliedHealthRestoration = buff.applyHealth(to: appliedHealthRestoration, source: source)!
                }
            }
            // Target buffs
            for buff in target.getAllBuffsInPriority() {
                if buff.type == .health && (buff.direction == .incoming || buff.direction == .bidirectional) {
                    appliedHealthRestoration = buff.applyHealth(to: appliedHealthRestoration, source: source)!
                }
            }
        }
        return appliedHealthRestoration
    }
    
    static func getAppliedArmorPointsRestoration(owner: ActorAbstract, using source: Any, target: ActorAbstract, armorPointsRestoration: Int) -> Int {
        var appliedArmorPointsRestoration = armorPointsRestoration
        if owner.id == target.id {
            for buff in target.getAllBuffsInPriority() {
                if buff.type == .armorPoints {
                    appliedArmorPointsRestoration = buff.applyArmorPoints(to: appliedArmorPointsRestoration, source: source)!
                }
            }
        } else {
            // Owner buffs
            for buff in owner.getAllBuffsInPriority() {
                if buff.type == .armorPoints && (buff.direction == .outgoing || buff.direction == .bidirectional) {
                    appliedArmorPointsRestoration = buff.applyArmorPoints(to: appliedArmorPointsRestoration, source: source)!
                }
            }
            // Target buffs
            for buff in target.getAllBuffsInPriority() {
                if buff.type == .armorPoints && (buff.direction == .incoming || buff.direction == .bidirectional) {
                    appliedArmorPointsRestoration = buff.applyArmorPoints(to: appliedArmorPointsRestoration, source: source)!
                }
            }
        }
        return appliedArmorPointsRestoration
    }
    
    static func getAdjustedPrice(purchaser: Player, price: Int) -> Int {
        var adjustedPrice = price
        for buff in purchaser.getAllBuffsInPriority() {
            if buff.type == .price {
                adjustedPrice = buff.applyPrice(to: adjustedPrice)!
            }
        }
        return adjustedPrice
    }
    
    static func getAdjustedGoldWithBonus(receiver: Player, gold: Int) -> Int {
        var adjustedGold = gold
        for buff in receiver.getAllBuffsInPriority() {
            if buff.type == .goldBonus {
                adjustedGold = buff.applyGoldBonus(to: adjustedGold)!
            }
        }
        return adjustedGold
    }
    
}
