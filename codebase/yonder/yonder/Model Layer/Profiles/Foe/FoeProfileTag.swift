//
//  FoeProfileTag.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation

/// These are unique in that a foe profile can contain multiple of these (can be obtuse and a brute) however in-game we only ever request one (you'll never encounter an obtuse-brute foe).
/// Allowing foe profiles to have multiple profile tags allow for a fallback if there aren't enough of a certain type of profile.
/// For instance, if the player encounters a brute foe, and the number of brute foe profiles for the current region is depleted, we can fall back and return an obtuse foe profile which is "close enough".
/// Again, if there are also no more obtuse foe profiles, we can return just a regular foe to compensate.
/// It also allows for granularity during this process. First we look to return purely obtuse, then we'll look for obtuse + brute, etc.
enum FoeProfileTag: String {
    
    case none // Only applies if the foe is not obtuse, acute, goblin nor brute
    case obtuse
    case acute
    case goblin
    case brute
    
}
