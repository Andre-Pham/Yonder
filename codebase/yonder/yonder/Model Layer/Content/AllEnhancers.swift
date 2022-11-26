//
//  AllEnhancers.swift
//  yonder
//
//  Created by Andre Pham on 27/12/21.
//

import Foundation

enum Enhancers {
    
    // TODO: Remove
    static func newTestEnhancer() -> Enhancer {
        return Enhancer(offers: [ArmorPointsEnhanceOffer(price: 10, armorPoints: 50), EnhanceOffers.lifestealForWeapon(stage: 0)])
    }
    
}
