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
    var candidateIDs: [UUID] { get }
    
    func acceptOffer(player: Player, candidateID: UUID)
    
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
