//
//  Restorer.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class Restorer: InteractorAbstract {
    
    enum RestoreOption {
        case health
        case armorPoints
        
        var id: UUID {
            switch self {
            case .health: return UUID(uuidString: "536F97B9-2C1C-493C-BE6E-759AFCE2D2C5")!
            case .armorPoints: return UUID(uuidString: "9B8E8B99-8687-4235-BC05-75E9136B551D")!
            }
        }
    }
    
    public let options: [RestoreOption]
    public let pricePerHealth: Int
    public let pricePerArmorPoint: Int
    
    init(name: String = "placeholderName", description: String = "placerholderDescription", options: [RestoreOption], pricePerHealth: Int = 0, pricePerArmorPoint: Int = 0) {
        self.options = options
        self.pricePerHealth = pricePerHealth
        self.pricePerArmorPoint = pricePerArmorPoint
        
        super.init(name: name, description: description)
    }
    
    func restoreHealth(to purchaser: Player, amount: Int) {
        var amountPurchased = amount
        let adjustedPrice = BuffApps.getAdjustedPrice(purchaser: purchaser, price: self.pricePerHealth)
        if adjustedPrice*amount > purchaser.gold {
            let amountAffordable: Double = Double(purchaser.gold)/Double(adjustedPrice)
            amountPurchased = Int(floor(amountAffordable))
        }
        purchaser.modifyGold(by: -self.pricePerHealth*amountPurchased)
        purchaser.restoreHealthAdjusted(sourceOwner: Proxies.NO_ACTOR, using: Proxies.NO_ITEM, for: amountPurchased)
    }
    
    func restoreArmorPoints(to purchaser: Player, amount: Int) {
        var amountPurchased = amount
        let adjustedPrice = BuffApps.getAdjustedPrice(purchaser: purchaser, price: self.pricePerArmorPoint)
        if adjustedPrice*amount > purchaser.gold {
            let amountAffordable: Double = Double(purchaser.gold)/Double(adjustedPrice)
            amountPurchased = Int(floor(amountAffordable))
        }
        purchaser.modifyGoldAdjusted(by: -self.pricePerArmorPoint*amountPurchased)
        purchaser.restoreArmorPointsAdjusted(sourceOwner: Proxies.NO_ACTOR, using: Proxies.NO_ITEM, for: amountPurchased)
    }
    
}
