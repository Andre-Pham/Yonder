//
//  YonderTerminology.swift
//  yonder
//
//  Created by Andre Pham on 7/2/2022.
//

import Foundation

typealias Term = YonderTerminology
enum YonderTerminology {
    
    static let none = "none"
    
    static let health = "health"
    static let armorPoints = "shields"
    static let gold = "gold"
    static let currencySymbol = "$"
    
    static let player = "you"
    static let foe = "hostile"
    
    static let damage = "damage"
    static let healthRestoration = "healing"
    static let healthRestore = "heal"
    static let armorPointsRestoration = "repairing"
    static let armorPointsRestore = "repair"
    static let remainingUses = "remaining uses"
    static let remainingUse = "remaining use"
    static let weaponRemainingUses = "durability"
    static let potionRemainingUses = "potions"
    static let use = "use"
    static let instantUse = "instant use"
    static let restoration = "mending"
    static let restore = "restore"
    static let restores = "restores"
    static let purchase = "purchase"
    static let enhance = "enhance"
    
    static let armor = "armor"
    static let headArmorSlot = "head"
    static let bodyArmorSlot = "body"
    static let legsArmorSlot = "legs"
    static func armorSlot(of armorType: ArmorType) -> String {
        switch armorType {
        case .head:
            return Term.headArmorSlot
        case .body:
            return Term.bodyArmorSlot
        case .legs:
            return Term.legsArmorSlot
        }
    }
    
    static let stats = "stats"
    static let buffOrEffect = "status effect" // Covers both buffs(/debuffs) and status effects
    static let buffsAndEffects = "status effects" // Covers both buffs(/debuffs) and status effects
    static let weaponEffect = "effect"
    static let options = "game"
    static let inventory = "inventory"
    static let map = "map"
    static let settings = "settings"
    
    static let travel = "travel"
    static let shop = "shop"
    static let purchaseItems = "shop"
    
    static let weapons = "weapons"
    static let weapon = "weapon"
    static let potions = "potions"
    static let potion = "potion"
    static let accessories = "accessories"
    static let accessory = "accessory"
    static let offer = "offer"
    static let offers = "offers"
    static let enhanceables = "items"
    
    static func magnitudeChangeFromMultiplying(_ fraction: Double) -> String? {
        if fraction < 1 {
            return "reduces"
        }
        else if fraction > 1 {
            return "increases"
        }
        return nil
    }
    
    static func magnitudeChangeFromAdding(_ number: Int) -> String? {
        if number < 0 {
            return "reduces"
        }
        else if number > 0 {
            return "increases"
        }
        return nil
    }
    
    static func negativeEffectDirection(of direction: BuffAbstract.BuffDirection) -> String {
        switch direction {
        case .bidirectional:
            return "dealt and received"
        case .outgoing:
            return "dealt"
        case .incoming:
            return "received"
        }
    }
    
    static func positiveEffectDirection(of direction: BuffAbstract.BuffDirection) -> String {
        switch direction {
        case .bidirectional:
            return "restored and given to others"
        case .outgoing:
            return "given to others"
        case .incoming:
            return "restored"
        }
    }
    
    static func goldPaymentDirection(of direction: BuffAbstract.BuffDirection) -> String {
        switch direction {
        case .bidirectional:
            return "earnt and paid out"
        case .outgoing:
            return "paid out"
        case .incoming:
            return "earnt"
        }
    }
    
    static func getPercentageFromDouble(_ fraction: Double) -> String {
        return "\(round((100.0*(1.0 - fraction))))%"
    }
    
}
