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
    private let priceAdjustment: Double
    public var price: Int {
        return (self.priceAdjustment*Double(self.item.getBasePurchasePrice())).toRoundedInt()
    }
    @DidSetPublished private(set) var stockRemaining: Int
    public let id = UUID()
    public let info: PurchasableItemInfo
    
    init(
        item: Purchasable,
        stock: Int,
        priceAdjustment: Double = Random.selectFromNormalDistribution(min: 0.65, max: 1.35)
    ) {
        self.item = item
        self.stockRemaining = stock
        self.info = item.getPurchaseInfo()
        self.priceAdjustment = priceAdjustment
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
