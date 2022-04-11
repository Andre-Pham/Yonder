//
//  EnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 8/4/2022.
//

import Foundation

protocol EnhanceOffer: Named, Described {
    
    var id: UUID { get }
    var price: Int { get }
    
    func getEnhanceables(from player: Player) -> [Enhanceable]
    func acceptOffer(player: Player, enhanceableID: UUID)
    
}
extension EnhanceOffer {
    
    func canBePurchased(price: Int, purchaser: Player) -> Bool {
        let adjustedPrice = BuffApps.getAdjustedPrice(purchaser: purchaser, price: price)
        if adjustedPrice > purchaser.gold {
            return false
        }
        return true
    }
    
}
