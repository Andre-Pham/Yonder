//
//  MultiplyGoldConsumable.swift
//  yonder
//
//  Created by Andre Pham on 7/9/2022.
//

import Foundation

class MultiplyGoldConsumable: Consumable {
    
    private let goldFraction: Double
    
    init(goldFraction: Double) {
        self.goldFraction = goldFraction
        
        let percentage = self.goldFraction.toRelativePercentage(decimalPlaces: 0)
        super.init(
            name: Strings("consumable.multiplyGold.name").local,
            description: Strings("consumable.multiplyGold.description").local,
            effectsDescription: Strings("consumable.multiplyGold.effectsDescription1Param").localWithArgs(percentage)
        )
    }
    
    required init(_ original: ConsumableAbstract) {
        let original = original as! Self
        self.goldFraction = original.goldFraction
        super.init(original)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract?) {
        if let player = owner as? Player {
            player.modifyGoldAdjusted(by: Int(round(Double(player.gold)*abs(1.0 - self.goldFraction))))
            self.adjustRemainingUses(by: -1)
        }
    }
    
    func isStackable(with consumable: Consumable) -> Bool {
        if let consumable = consumable as? Self {
            return self.goldFraction == consumable.goldFraction
        }
        return false
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerGoldStat.getValue(amount: Pricing.playerGoldStat.baseStatAmount, uses: self.remainingUses)
    }
    
}
