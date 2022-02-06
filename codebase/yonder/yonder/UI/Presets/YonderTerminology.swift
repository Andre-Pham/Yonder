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
    static let buffsAndEffects = "status effects" // Covers both buffs(/debuffs) and status effects
    static let options = "game"
    static let inventory = "inventory"
    static let map = "map"
    static let settings = "settings"
    
    static let travel = "travel"
    
    static let weapons = "weapons"
    static let weapon = "weapon"
    static let potions = "potions"
    static let potion = "potion"
    static let accessories = "accessories"
    static let accessory = "accessory"
    
}
