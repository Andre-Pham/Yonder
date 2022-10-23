//
//  HasPurchasablePrice.swift
//  yonder
//
//  Created by Andre Pham on 24/10/2022.
//

import Foundation

/// When something has a price so it's purchasable by the player.
/// It's important to note that the purchase price is solely based on the player making the purchase (and hence equipping/using the received goods).
protocol HasPurchasablePrice {
    
    func calculateBasePurchasePrice() -> Int
    
}
