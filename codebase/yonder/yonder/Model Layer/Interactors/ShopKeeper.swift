//
//  ShopKeeper.swift
//  yonder
//
//  Created by Andre Pham on 2/12/21.
//

import Foundation

class ShopKeeper: InteractorAbstract {
    
    @DidSetPublished private(set) var purchasableItems: [PurchasableItem]
    
    init(name: String = "placeholderName", description: String = "placerholderDescription", purchasableItems: [PurchasableItem]) {
        self.purchasableItems = purchasableItems
        
        super.init(name: name, description: description)
    }
    
    func purchaseItem(_ item: PurchasableItem, amount: Int, purchaser: Player) {
        if let index = self.purchasableItems.firstIndex(where: { item.id == $0.id }) {
            self.purchaseItem(at: index, amount: amount, purchaser: purchaser)
        }
    }
    
    func purchaseItem(at index: Int, amount: Int, purchaser: Player) {
        self.purchasableItems[index].purchase(amount: amount, purchaser: purchaser)
        if self.purchasableItems[index].stockRemaining == 0 {
            self.purchasableItems.remove(at: index)
        }
    }
    
}


protocol Purchasable {
    
    var basePurchasePrice: Int { get }
    
    func getPurchaseInfo() -> PurchaseableItemInfo
    func beRecieved(by reciever: Player, amount: Int)
    
}

class PurchasableItem {
    
    private(set) var item: Purchasable
    public let price: Int
    @DidSetPublished private(set) var stockRemaining: Int
    public let id = UUID()
    public let info: PurchaseableItemInfo
    
    init(item: Purchasable, stock: Int) {
        self.item = item
        self.price = item.basePurchasePrice
        self.stockRemaining = stock
        self.info = item.getPurchaseInfo()
    }
    
    func purchase(amount: Int, purchaser: Player) {
        guard self.canPurchase(amount: amount, purchaser: purchaser) else {
            return
        }
        self.stockRemaining -= amount
        purchaser.modifyGoldAdjusted(by: -amount*self.price)
        self.item.beRecieved(by: purchaser, amount: amount)
    }
    
    func canPurchase(amount: Int, purchaser: Player) -> Bool {
        let adjustedPrice = BuffApps.getAdjustedPrice(purchaser: purchaser, price: self.price)
        if amount > self.stockRemaining || amount*adjustedPrice > purchaser.gold {
            return false
        }
        return true
    }
    
}

class PurchaseableItemInfo {
    
    public let name: String
    
    init(name: String) {
        self.name = name
    }
    
}
