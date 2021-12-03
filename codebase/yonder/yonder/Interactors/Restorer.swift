//
//  Restorer.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class Restorer: InteractorAbstract {
    
    public let options: [RestoreOptions]
    public let pricePerHealth: Int
    public let pricePerArmorPoint: Int
    
    enum RestoreOptions {
        case health
        case armorPoints
    }
    
    init(options: [RestoreOptions], pricePerHealth: Int = 0, pricePerArmorPoint: Int = 0) {
        self.options = options
        self.pricePerHealth = pricePerHealth
        self.pricePerArmorPoint = pricePerArmorPoint
    }
    
    func restoreHealth(to purchaser: Player, amount: Int) {
        var amountPurchased = amount
        let adjustedPrice = BuffApps.getAdjustedPrice(purchaser: purchaser, price: self.pricePerHealth)
        if adjustedPrice*amount > purchaser.gold {
            let amountAffordable: Double = Double(purchaser.gold)/Double(adjustedPrice)
            amountPurchased = Int(floor(amountAffordable))
        }
        let amountRestored = BuffApps.getAppliedHealthRestoration(owner: Proxies.NO_ACTOR, using: Proxies.NO_ITEM, target: purchaser, healthRestoration: amountPurchased)
        purchaser.adjustGold(by: -adjustedPrice*amountPurchased)
        purchaser.restoreHealth(for: amountRestored)
    }
    
    func restoreArmorPoints(to purchaser: Player, amount: Int) {
        var amountPurchased = amount
        let adjustedPrice = BuffApps.getAdjustedPrice(purchaser: purchaser, price: self.pricePerArmorPoint)
        if adjustedPrice*amount > purchaser.gold {
            let amountAffordable: Double = Double(purchaser.gold)/Double(adjustedPrice)
            amountPurchased = Int(floor(amountAffordable))
        }
        let amountRestored = BuffApps.getAppliedArmorRestoration(owner: Proxies.NO_ACTOR, using: Proxies.NO_ITEM, target: purchaser, armorPointsRestoration: amountPurchased)
        purchaser.adjustGold(by: -adjustedPrice*amountPurchased)
        purchaser.restoreArmorPoints(for: amountRestored)
    }
    
}
