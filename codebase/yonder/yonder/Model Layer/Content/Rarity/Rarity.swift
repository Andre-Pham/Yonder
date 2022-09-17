//
//  Rarity.swift
//  yonder
//
//  Created by Andre Pham on 6/9/2022.
//

import Foundation

/// The relative rarities any entity can have.
/// Rarity doesn't correlate to strength. Just because an entity is legendary, doesn't mean it's very strong. It may just have a unique effect.
enum Rarity: Int {
    case common = 100
    case semicommon = 50
    case uncommon = 25
    case rare = 10
    case epic = 5
    case legendary = 1
    
    /// The amount of occurrences for a given entity with a certain rarity compared to another entity with a different rarity.
    /// For example, every 100 common entities, there will be 25 uncommon ones, and 1 legendary one.
    var frequencyRatio: Int {
        return self.rawValue
    }
}
