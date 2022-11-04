//
//  LocationAttributes.swift
//  yonder
//
//  Created by Andre Pham on 19/12/21.
//

import Foundation
import SwiftUI

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
            return Strings("map.locationType.none.name").local
        case .hostile:
            return Strings("map.locationType.hostile.name").local
        case .challengeHostile:
            return Strings("map.locationType.challengeHostile.name").local
        case .shop:
            return Strings("map.locationType.shop.name").local
        case .enhancer:
            return Strings("map.locationType.enhancer.name").local
        case .restorer:
            return Strings("map.locationType.restorer.name").local
        case .quest:
            return Strings("map.locationType.quest.name").local
        case .friendly:
            return Strings("map.locationType.friendly.name").local
        case .boss:
            return Strings("map.locationType.boss.name").local
        case .bridge:
            return Strings("map.locationType.bridge.name").local
        }
    }
    
    var description: String {
        switch self {
        case .none:
            return Strings("map.locationType.none.description").local
        case .hostile:
            return Strings("map.locationType.hostile.description").local
        case .challengeHostile:
            return Strings("map.locationType.challengeHostile.description").local
        case .shop:
            return Strings("map.locationType.shop.description").local
        case .enhancer:
            return Strings("map.locationType.enhancer.description").local
        case .restorer:
            return Strings("map.locationType.restorer.description").local
        case .quest:
            return Strings("map.locationType.quest.description").local
        case .friendly:
            return Strings("map.locationType.friendly.description").local
        case .boss:
            return Strings("map.locationType.boss.description").local
        case .bridge:
            return Strings("map.locationType.bridge.description").local
        }
    }
    
    var image: Image {
        switch self {
        case .none:
            return YonderImages.missingIcon
        case .hostile:
            return YonderImages.hostileIcon
        case .challengeHostile:
            return YonderImages.challengeHostileIcon
        case .shop:
            return YonderImages.shopIcon
        case .enhancer:
            return YonderImages.enhancerIcon
        case .restorer:
            return YonderImages.restorerIcon
        case .quest:
            return YonderImages.missingIcon
        case .friendly:
            return YonderImages.friendlyIcon
        case .boss:
            return YonderImages.missingIcon
        case .bridge:
            return YonderImages.warpIcon
        }
    }
}

protocol FoeLocation {
    
    var foe: Foe { get }
    
}
