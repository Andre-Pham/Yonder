//
//  AllFriendlies.swift
//  yonder
//
//  Created by Andre Pham on 27/12/21.
//

import Foundation

enum Friendlies {
    
    // MARK: - Test Friendlies
    
    static func newTestFriendly() -> Friendly {
        return Friendly(
            offers: [
                FreeGoldOffer(goldAmount: 500)
            ],
            offerLimit: 1)
    }
    
    // MARK:  - Stage 0
    
}
