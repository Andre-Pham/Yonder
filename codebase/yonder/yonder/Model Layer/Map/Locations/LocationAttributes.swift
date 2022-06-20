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
            return Strings.Map.LocationType.None.Name.local
        case .hostile:
            return Strings.Map.LocationType.Hostile.Name.local
        case .challengeHostile:
            return Strings.Map.LocationType.ChallengeHostile.Name.local
        case .shop:
            return Strings.Map.LocationType.Shop.Name.local
        case .enhancer:
            return Strings.Map.LocationType.Enhancer.Name.local
        case .restorer:
            return Strings.Map.LocationType.Restorer.Name.local
        case .quest:
            return Strings.Map.LocationType.Quest.Name.local
        case .friendly:
            return Strings.Map.LocationType.Friendly.Name.local
        case .boss:
            return Strings.Map.LocationType.Boss.Name.local
        case .bridge:
            return Strings.Map.LocationType.Bridge.Name.local
        }
    }
    
    var description: String {
        switch self {
        case .none:
            return Strings.Map.LocationType.None.Description.local
        case .hostile:
            return Strings.Map.LocationType.Hostile.Description.local
        case .challengeHostile:
            return Strings.Map.LocationType.ChallengeHostile.Description.local
        case .shop:
            return Strings.Map.LocationType.Shop.Description.local
        case .enhancer:
            return Strings.Map.LocationType.Enhancer.Description.local
        case .restorer:
            return Strings.Map.LocationType.Restorer.Description.local
        case .quest:
            return Strings.Map.LocationType.Quest.Description.local
        case .friendly:
            return Strings.Map.LocationType.Friendly.Description.local
        case .boss:
            return Strings.Map.LocationType.Boss.Description.local
        case .bridge:
            return Strings.Map.LocationType.Bridge.Description.local
        }
    }
}

protocol FoeLocation {
    
    var foe: Foe { get }
    
}
