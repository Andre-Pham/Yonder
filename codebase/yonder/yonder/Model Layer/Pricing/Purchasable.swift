//
//  Purchasable.swift
//  yonder
//
//  Created by Andre Pham on 11/4/2022.
//

import Foundation

/// When something is purchasable by the player.
/// It's important to note that the purchase price is solely based on the player making the purchase (and hence equipping/using the received goods).
protocol Purchasable {
    
    func getBasePurchasePrice() -> Int
    func getPurchaseInfo() -> PurchasableItemInfo
    func beReceived(by receiver: Player, amount: Int)
    
}
