//
//  PurchasableItem.swift
//  yonder
//
//  Created by Andre Pham on 11/4/2022.
//

import Foundation

class PurchasableItem {
    
    enum PurchasableItemType: CaseIterable {
        case weapon
        case potion
        case armor
        case accessory
        case consumable
        
        var categoryDescription: String {
            switch self {
            case .weapon:
                return Strings("purchasableItem.category.weapons").local
            case .potion:
                return Strings("purchasableItem.category.potions").local
            case .armor:
                return Strings("purchasableItem.category.armor").local
            case .accessory:
                return Strings("purchasableItem.category.accessories").local
            case .consumable:
                return Strings("purchasableItem.category.consumables").local
            }
        }
    }
    
    private(set) var item: Purchasable
    public var price: Int {
        return self.item.getBasePurchasePrice()
    }
    @DidSetPublished private(set) var stockRemaining: Int
    public let id = UUID()
    public let info: PurchasableItemInfo
    
    init(item: Purchasable, stock: Int) {
        self.item = item
        self.stockRemaining = stock
        self.info = item.getPurchaseInfo()
    }
    
    func purchase(amount: Int, purchaser: Player) {
        guard self.canPurchase(amount: amount, purchaser: purchaser) else {
            return
        }
        self.stockRemaining -= amount
        purchaser.modifyGoldAdjusted(by: -amount*self.price)
        self.item.beReceived(by: purchaser, amount: amount)
    }
    
    func canPurchase(amount: Int, purchaser: Player) -> Bool {
        let adjustedPrice = BuffApps.getAdjustedPrice(purchaser: purchaser, price: self.price)
        if amount > self.stockRemaining || amount*adjustedPrice > purchaser.gold {
            return false
        }
        return true
    }
    
}
