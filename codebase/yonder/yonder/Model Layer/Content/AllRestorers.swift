//
//  AllRestorers.swift
//  yonder
//
//  Created by Andre Pham on 27/12/21.
//

import Foundation

enum Restorers {
    
    // MARK: - Test Restorers
    
    static func newTestRestorer() -> Restorer {
        return Restorer(options: [.armorPoints, .health], pricePerHealth: 10, pricePerArmorPoint: 15)
    }
    
    // MARK:  - Stage 0
    
}
