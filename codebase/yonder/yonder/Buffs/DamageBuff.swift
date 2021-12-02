//
//  DamageBuff.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class DamageBuff: BuffAbstract {
    
    private let damageDifference: Int
    
    init(duration: Int, damageDifference: Int) {
        self.damageDifference = damageDifference
        
        super.init(duration: duration, type: .damage, priority: 0)
    }
    
    override func applyDamage(to damage: Int, source: Any) -> Int? {
        return self.damageDifference + damage
    }
    
}
