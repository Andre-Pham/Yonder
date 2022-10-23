//
//  HasPriceValue.swift
//  yonder
//
//  Created by Andre Pham on 3/10/2022.
//

import Foundation

/// When something has a value.
/// All value is measured in gold, hence "price value".
protocol HasPriceValue {
    
    func getValue(whenTargeting target: Target) -> Int
    
}

enum Target {
    
    case player
    case foe
    
}
