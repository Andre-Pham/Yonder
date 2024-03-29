//
//  LocationAttributes.swift
//  yonder
//
//  Created by Andre Pham on 19/12/21.
//

import Foundation
import SwiftUI

enum LocationBridgeAccessibility: Int {
    case leftBridge = 1 // A bridge can be formed from this node to an area to the left
    case rightBridge = 2 // A bridge can be formed from this node to an area to the right
    case noBridge = 0
}

enum LocationType: Int {
    case none = 0
    case hostile = 1
    case challengeHostile = 2
    case shop = 3
    case enhancer = 4 // For upgrades
    case restorer = 5 // For health and armor restoration
    case friendly = 6
    case boss = 7
    case bridge = 8
    case starting = 9
    
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
        case .friendly:
            return Strings("map.locationType.friendly.name").local
        case .boss:
            return Strings("map.locationType.boss.name").local
        case .bridge:
            return Strings("map.locationType.bridge.name").local
        case .starting:
            return Strings("map.locationType.starting.name").local
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
        case .friendly:
            return Strings("map.locationType.friendly.description").local
        case .boss:
            return Strings("map.locationType.boss.description").local
        case .bridge:
            return Strings("map.locationType.bridge.description").local
        case .starting:
            return Strings("map.locationType.starting.description").local
        }
    }
    
    var summary: String {
        switch self {
        case .none:
            return Strings("map.locationType.none.summary").local
        case .hostile:
            return Strings("map.locationType.hostile.summary").local
        case .challengeHostile:
            return Strings("map.locationType.challengeHostile.summary").local
        case .shop:
            return Strings("map.locationType.shop.summary").local
        case .enhancer:
            return Strings("map.locationType.enhancer.summary").local
        case .restorer:
            return Strings("map.locationType.restorer.summary").local
        case .friendly:
            return Strings("map.locationType.friendly.summary").local
        case .boss:
            return Strings("map.locationType.boss.summary").local
        case .bridge:
            return Strings("map.locationType.bridge.summary").local
        case .starting:
            return Strings("map.locationType.starting.summary").local
        }
    }
    
    var image: Image {
        switch self {
        case .none:
            return YonderIcons.missingIcon
        case .hostile:
            return YonderIcons.hostileIcon
        case .challengeHostile:
            return YonderIcons.challengeHostileIcon
        case .shop:
            return YonderIcons.shopIcon
        case .enhancer:
            return YonderIcons.enhancerIcon
        case .restorer:
            return YonderIcons.restorerIcon
        case .friendly:
            return YonderIcons.friendlyIcon
        case .boss:
            return YonderIcons.bossIcon
        case .bridge:
            return YonderIcons.warpIcon
        case .starting:
            return YonderIcons.startingLocationIcon
        }
    }
}

protocol FoeLocation {
    
    var foe: Foe { get }
    
}

protocol InteractorLocation {
    
    func getInteractor() -> InteractorAbstract?
    
}
