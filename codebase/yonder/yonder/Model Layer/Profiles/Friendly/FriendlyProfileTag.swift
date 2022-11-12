//
//  FriendlyProfileTag.swift
//  yonder
//
//  Created by Andre Pham on 12/11/2022.
//

import Foundation

enum FriendlyProfileTag {
    
    /// Requires the player to sacrifice something, for example health, permanent health
    case sacrifice
    /// Requires the player to get cursed, for example a permanent 5% damage decrease buff
    case curse
    /// Trading gold for (potentially special) items
    case shop
    /// Anything that requires the player to give up items
    case trade
    /// The player just gets something for free
    case generous
    
    // curse for blessing: player healing is permanently reduced by 20% (curse)
    // but the player's damage is permanently increased by 30% (blessing)
    // (give the curse and blessing cool names, you pass it in via the buff source)
    
    // all weapons get +5 attack
    
}
