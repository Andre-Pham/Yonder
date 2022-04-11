//
//  AllEnhancers.swift
//  yonder
//
//  Created by Andre Pham on 27/12/21.
//

import Foundation

enum Enhancers {
    
    // MARK: - Test Enhancers
    
    static func newTestEnhancer() -> Enhancer {
        return Enhancer(offers: [ArmorPointsEnhanceOffer(price: 10, armorPoints: 50)])
    }
    
    // MARK:  - Stage 0
    
}
