//
//  BuffApplications.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

typealias BuffApps = BuffApplications
enum BuffApplications {
    
    private static let MAX_PRICE_DISCOUNT = 0.75
    
    static func getAppliedDamage(owner: ActorAbstract, using source: Any, target: ActorAbstract, damage: Int) -> Int {
        if damage == 0 {
            // If there's no damage to buff, we don't buff it
            // E.g. it's unfair if you have something that deals 0 damage to deal any damage from buffs
            return 0
        }
        var appliedDamage = damage
        if owner.id == target.id {
            for buff in target.getAllBuffsInPriority() {
                if buff.type == .damage {
                    appliedDamage = buff.applyDamage(to: appliedDamage, source: source)
                }
            }
        } else {
            // Owner buffs
            for buff in owner.getAllBuffsInPriority() {
                if buff.type == .damage && (buff.direction == .outgoing || buff.direction == .bidirectional) {
                    appliedDamage = buff.applyDamage(to: appliedDamage, source: source)
                }
            }
            // Target buffs
            for buff in target.getAllBuffsInPriority() {
                if buff.type == .damage && (buff.direction == .incoming || buff.direction == .bidirectional) {
                    appliedDamage = buff.applyDamage(to: appliedDamage, source: source)
                }
            }
        }
        if appliedDamage < 0 {
            // Can't apply negative damage
            appliedDamage = 0
        }
        return appliedDamage
    }
    
    static func getAppliedRestoration(owner: ActorAbstract, using source: Any, target: ActorAbstract, restoration: Int) -> (Int, Int) {
        if restoration == 0 {
            // If there's no restoration to buff, we don't buff it
            // E.g. it's unfair if you have something that gives +5 restoration to heal you for 5 after you heal for 0
            return (0, 0)
        }
        let healthMultiplier: Double = Double(BuffApps.getAppliedHealthRestoration(owner: owner, using: source, target: target, healthRestoration: restoration))/Double(restoration)
        let armorMultiplier: Double = Double(BuffApps.getAppliedArmorPointsRestoration(owner: owner, using: source, target: target, armorPointsRestoration: restoration))/Double(restoration)
        let availableHealthRestoration = Double(restoration)*healthMultiplier
        let healthRestoration = min(Double(target.maxHealth - target.health), availableHealthRestoration)
        let availableArmorPointsRestoration = {
            if isZero(healthMultiplier) {
                // No health multiplier means zero health can be restored because buffs reduce healing to <= 0
                // Hence all the restoration can go to armor
                return Double(restoration)*armorMultiplier
            } else {
                // Reduce the allocated amount of restoration for armor points by the equivalent amount used for healing health
                return (Double(restoration) - healthRestoration/healthMultiplier)*armorMultiplier
            }
        }()
        let armorPointsRestoration = min(Double(target.maxArmorPoints - target.armorPoints), availableArmorPointsRestoration)
        return (Int(round(healthRestoration)), Int(round(armorPointsRestoration)))
    }
    
    static func getAppliedHealthRestoration(owner: ActorAbstract, using source: Any, target: ActorAbstract, healthRestoration: Int) -> Int {
        if healthRestoration == 0 {
            // If there's no health restoration to buff, we don't buff it
            // E.g. it's unfair if you have something that gives +5 healing to heal you for 5 after you heal for 0
            return 0
        }
        var appliedHealthRestoration = healthRestoration
        if owner.id == target.id {
            for buff in target.getAllBuffsInPriority() {
                if buff.type == .health {
                    appliedHealthRestoration = buff.applyHealth(to: appliedHealthRestoration, source: source)
                }
            }
        } else {
            // Owner buffs
            for buff in owner.getAllBuffsInPriority() {
                if buff.type == .health && (buff.direction == .outgoing || buff.direction == .bidirectional) {
                    appliedHealthRestoration = buff.applyHealth(to: appliedHealthRestoration, source: source)
                }
            }
            // Target buffs
            for buff in target.getAllBuffsInPriority() {
                if buff.type == .health && (buff.direction == .incoming || buff.direction == .bidirectional) {
                    appliedHealthRestoration = buff.applyHealth(to: appliedHealthRestoration, source: source)
                }
            }
        }
        if appliedHealthRestoration < 0 {
            // Can't apply negative health restoration
            appliedHealthRestoration = 0
        }
        return appliedHealthRestoration
    }
    
    static func getAppliedArmorPointsRestoration(owner: ActorAbstract, using source: Any, target: ActorAbstract, armorPointsRestoration: Int) -> Int {
        if armorPointsRestoration == 0 {
            // If there's no armor points restoration to buff, we don't buff it
            // E.g. it's unfair if you have something that gives +5 armor points restoration to repair you for 5 after you repair for 0
            return 0
        }
        var appliedArmorPointsRestoration = armorPointsRestoration
        if owner.id == target.id {
            for buff in target.getAllBuffsInPriority() {
                if buff.type == .armorPoints {
                    appliedArmorPointsRestoration = buff.applyArmorPoints(to: appliedArmorPointsRestoration, source: source)
                }
            }
        } else {
            // Owner buffs
            for buff in owner.getAllBuffsInPriority() {
                if buff.type == .armorPoints && (buff.direction == .outgoing || buff.direction == .bidirectional) {
                    appliedArmorPointsRestoration = buff.applyArmorPoints(to: appliedArmorPointsRestoration, source: source)
                }
            }
            // Target buffs
            for buff in target.getAllBuffsInPriority() {
                if buff.type == .armorPoints && (buff.direction == .incoming || buff.direction == .bidirectional) {
                    appliedArmorPointsRestoration = buff.applyArmorPoints(to: appliedArmorPointsRestoration, source: source)
                }
            }
        }
        if appliedArmorPointsRestoration < 0 {
            // Can't apply negative armor points restoration
            appliedArmorPointsRestoration = 0
        }
        return appliedArmorPointsRestoration
    }
    
    static func getAdjustedPrice(purchaser: Player, price: Int) -> Int {
        if price == 0 {
            // If something is free we don't apply price buffs
            // Discounts don't make any sense
            // Debuffs that cause things to be more expensive aren't supposed to apply to free things
            return 0
        }
        let originalSign = price.signum()
        var adjustedPrice = abs(price)
        for buff in purchaser.getAllBuffsInPriority() {
            if buff.type == .price {
                adjustedPrice = buff.applyPrice(to: adjustedPrice)
            }
        }
        // We have a set max discount so things can't be free (or "pay" you)
        let maxDiscountedPrice = abs((Double(price)*(1.0 - Self.MAX_PRICE_DISCOUNT)).toRoundedInt())
        if adjustedPrice < maxDiscountedPrice {
            adjustedPrice = maxDiscountedPrice
        }
        assert(adjustedPrice > 0, "Discounted price should not reach below or (at this stage) equal to zero")
        return adjustedPrice*originalSign
    }
    
    static func getAdjustedGoldWithBonus(receiver: Player, gold: Int) -> Int {
        if gold == 0 {
            // If there's no gold to buff, we don't buff it
            // E.g. it's unfair if you have something that gives +5 gold to pay you after you receive 0
            return 0
        }
        var adjustedGold = gold
        for buff in receiver.getAllBuffsInPriority() {
            if buff.type == .goldBonus {
                adjustedGold = buff.applyGoldBonus(to: adjustedGold)
            }
        }
        if adjustedGold < 0 {
            // Can't apply negative gold payout
            adjustedGold = 0
        }
        return adjustedGold
    }
    
}
