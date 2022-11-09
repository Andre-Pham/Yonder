//
//  RandomHealthConsumable.swift
//  yonder
//
//  Created by Andre Pham on 7/9/2022.
//

import Foundation

class RandomHealthConsumable: Consumable {
    
    init(amount: Int) {
        super.init(
            name: Strings("consumable.randomHealth.name").local,
            description: Strings("consumable.randomHealth.description").local,
            effectsDescription: Strings("consumable.randomHealth.effectsDescription").local,
            remainingUses: amount
        )
    }
    
    required init(_ original: ConsumableAbstract) {
        super.init(original)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract?) {
        // We don't want to set the player to the health they're already at... that'd be boring.
        var range = [Int](1...owner.maxHealth)
        range.remove(at: owner.health-1)
        let index = Int(arc4random_uniform(UInt32(range.count)))
        owner.setHealth(to: range[index])
        self.adjustRemainingUses(by: -1)
    }
    
    func isStackable(with consumable: Consumable) -> Bool {
        return consumable is Self
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerHealthRestorationStat.getValue(amount: Pricing.playerHealthStat.baseStatAmount/3, uses: self.remainingUses)
    }
    
}
