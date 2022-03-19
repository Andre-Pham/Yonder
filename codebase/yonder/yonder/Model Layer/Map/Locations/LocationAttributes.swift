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
}

protocol FoeLocation {
    
    var foe: Foe { get }
    
}
