//
//  AccessoryBuffAbstract.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class AccessoryBuffAbstract: BuffAbstract {
    
    init(type: BuffType, priority: Int) {
        super.init(duration: 1, type: type, priority: priority)
    }
    
    override func decrementTimeRemaining() {
        // Accessory buffs don't have a lifespan
        return
    }
    
}
