//
//  LocationAttributes.swift
//  yonder
//
//  Created by Andre Pham on 19/12/21.
//

import Foundation

enum LocationBridgeAccessibility {
    case leftBridge // A bridge can be formed from this node to an area to the left
    case rightBridge // A bridge can be formed from this node to an area to the right
    case noBridge
}

enum LocationType {
    case none
    case hostile
    case challengeHostile
    case shop
    case enhancer // For upgrades
    case restorer // For health and armor restoration
    case quest // TODO: Implement quests later
    case friendly
    case boss
    case bridge
    
    var name: String {
        switch self {
        case .none:
            return Term.none.capitalized
        case .hostile:
            return Term.foeLocation.capitalized
        case .challengeHostile:
            return Term.challengeHostileLocation.capitalized
        case .shop:
            return Term.shopLocation.capitalized
        case .enhancer:
            return Term.enhancerLocation.capitalized
        case .restorer:
            return Term.restorerLocation.capitalized
        case .quest:
            return Term.questLocation.capitalized
        case .friendly:
            return Term.friendlyLocation.capitalized
        case .boss:
            return Term.bossLocation.capitalized
        case .bridge:
            return Term.bridgeLocation.capitalized
        }
    }
    
    var npcName: String {
        switch self {
        case .none:
            return Term.none.capitalized
        case .hostile:
            return Term.foe.capitalized
        case .challengeHostile:
            return Term.challengeHostile.capitalized
        case .shop:
            return Term.shopkeeper.capitalized
        case .enhancer:
            return Term.enhancer.capitalized
        case .restorer:
            return Term.restorer.capitalized
        case .quest:
            return Term.quest.capitalized
        case .friendly:
            return Term.friendly.capitalized
        case .boss:
            return Term.boss.capitalized
        case .bridge:
            return Term.none.capitalized
        }
    }
    
    var npcDescription: String {
        switch self {
        case .none:
            return Term.none.capitalized
        case .hostile:
            return "Hostiles engage you in combat, stop you from travelling, and drop loot upon defeat."
        case .challengeHostile:
            return "Mini bosses are tougher than regular hostiles, and also stop you from travelling. Luckily, they also reward better loot."
        case .shop:
            return "Shopkeepers will sell to you for a fair price. Browse their shop to see what they have to offer - each item has [remaining stock] which limits how much of it you can buy."
        case .enhancer:
            return "Enhancers have offers on certain gear they can upgrade. So long as you have the gold, you may upgrade a piece of gear however many times you desire."
        case .restorer:
            return "Menders will offer restoration of health and/or shields for gold."
        case .quest:
            return "Quests aren't implemented yet."
        case .friendly:
            return "Traders will offer you any number of different types exchanges, which can vary wildly in nature. Each trader has a limit on the number of times you may accept an offer from them."
        case .boss:
            return "Bosses are the highest form of hostile you'll encounter. Be prepared for a tough fight."
        case .bridge:
            return "Warps allow you to travel between areas, both forwards and backwards."
        }
    }
}

protocol FoeLocation {
    
    var foe: Foe { get }
    
}
