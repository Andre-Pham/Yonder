//
//  ShopKeeper.swift
//  yonder
//
//  Created by Andre Pham on 2/12/21.
//

import Foundation

protocol Purchasable {
    
    var basePurchasePrice: Int { get }
    
}

struct PurchasableItem {
    
    private(set) var item: Purchasable
    public let price: Int
    private(set) var stockRemaining: Int
    
    init(item: Purchasable, stock: Int) {
        self.item = item
        self.price = item.basePurchasePrice
        self.stockRemaining = stock
    }
    
    mutating func purchase(amount: Int, purchaser: Player) {
        let adjustedPrice = BuffApps.getAdjustedPrice(purchaser: purchaser, price: self.price)
        var amountPurchased: Int = amount > stockRemaining ? stockRemaining : amount
        if self.item is ArmorAbstract {
            amountPurchased = 1
        }
        if amountPurchased*adjustedPrice > purchaser.gold {
            let amountAffordable: Double = Double(purchaser.gold)/Double(adjustedPrice)
            amountPurchased = Int(floor(amountAffordable))
        }
        self.stockRemaining -= amountPurchased
        purchaser.modifyGoldAdjusted(by: -amountPurchased*self.price)
        if item is ArmorAbstract {
            purchaser.equipArmor(self.item as! ArmorAbstract)
        }
        else if item is PotionAbstract {
            for _ in 0..<amountPurchased {
                purchaser.addPotion(self.item as! PotionAbstract)
            }
        }
        else if item is WeaponAbstract {
            for _ in 0..<amountPurchased {
                purchaser.addWeapon(self.item as! WeaponAbstract)
            }
        }
    }
    
}

class ShopKeeper: InteractorAbstract {
    
    private(set) var purchasableItems: [PurchasableItem]
    
    init(purchasableItems: [PurchasableItem]) {
        self.purchasableItems = purchasableItems
    }
    
    func purchaseItem(at index: Int, amount: Int, purchaser: Player) {
        self.purchasableItems[index].purchase(amount: amount, purchaser: purchaser)
        if self.purchasableItems[index].stockRemaining == 0 {
            self.purchasableItems.remove(at: index)
        }
    }
    
}
