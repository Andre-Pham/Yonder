//
//  AllShops.swift
//  yonder
//
//  Created by Andre Pham on 27/12/21.
//

import Foundation

enum ShopKeepers {
    
    // MARK: - Test ShopKeepers
    
    static func newTestShopKeeper() -> ShopKeeper {
        return ShopKeeper(purchasableItems: [
            PurchasableItem(item: Accessory(name: "Damage/Health Accessory", description: "Very sharp, be careful while holding!", type: .regular, healthBonus: 50, armorPointsBonus: 0, basePurchasePrice: 10, buffs: [DamagePercentBuff(sourceName: "Damage/Health Accessory", direction: .outgoing, duration: nil, damageFraction: 1.5)], equipmentPills: []), stock: 5),
            PurchasableItem(item: Weapon(basePill: DamageBasePill(damage: 50), durabilityPill: DecrementDurabilityPill(durability: 5)), stock: 5),
            PurchasableItem(item: ArmorAbstract(name: "Strong Armor", description: "The toughest armor out there.", type: .body, armorPoints: 200, basePurchasePrice: 150, armorBuffs: [], equipmentPills: []), stock: 1),
            PurchasableItem(item: HealthRestorationPotion(tier: .III, potionCount: 3, basePurchasePrice: 100), stock: 5)
        ])
    }
    
    // MARK:  - Stage 0
    
}
