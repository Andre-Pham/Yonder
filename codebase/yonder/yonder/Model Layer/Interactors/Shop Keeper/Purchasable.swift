//
//  Purchasable.swift
//  yonder
//
//  Created by Andre Pham on 11/4/2022.
//

import Foundation

protocol Purchasable {
    
    var basePurchasePrice: Int { get }
    
    func getPurchaseInfo() -> PurchaseableItemInfo
    func beRecieved(by reciever: Player, amount: Int)
    
}
