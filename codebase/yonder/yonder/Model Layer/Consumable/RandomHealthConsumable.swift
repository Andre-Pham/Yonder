//
//  RandomHealthConsumable.swift
//  yonder
//
//  Created by Andre Pham on 7/9/2022.
//

import Foundation

class RandomHealthConsumable: ConsumableAbstract {
    
    init(basePurchasePrice: Int) {
        super.init(
            name: Strings.Consumable.RandomHealth.Name.local,
            description: Strings.Consumable.RandomHealth.Description.local,
            effectsDescription: Strings.Consumable.RandomHealth.EffectsDescription.local,
            basePurchasePrice: basePurchasePrice
        )
    }
    
    required init(_ original: ConsumableAbstractPart) {
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
    
    func isStackable(with consumable: ConsumableAbstract) -> Bool {
        return consumable is Self
    }
    
}
