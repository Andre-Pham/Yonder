//
//  TurnImprovingRestorationConsumable.swift
//  yonder
//
//  Created by Andre Pham on 7/9/2022.
//

import Foundation

class TurnImprovingRestorationConsumable: Consumable, OnTurnEndSubscriber {
    
    /// The amount of restoration this consumable starts with
    private let startingRestoration = 10
    /// The amount of restoration this improves by every turn
    private let restorationIncrease = 2
    
    init() {
        super.init(
            name: Strings("consumable.turnImprovingRestoration.name").local,
            description: Strings("consumable.turnImprovingRestoration.description").local,
            effectsDescription: Strings("consumable.turnImprovingRestoration.effectsDescription2Param").localWithArgs(self.startingRestoration, self.restorationIncrease),
            restoration: self.startingRestoration
        )
        
        OnTurnEndPublisher.subscribe(self)
    }
    
    required init(_ original: ConsumableAbstract) {
        let original = original as! Self
        super.init(
            name: original.name,
            description: original.description,
            effectsDescription: original.effectsDescription,
            restoration: original.restoration
        )
        
        OnTurnEndPublisher.subscribe(self)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract?) {
        owner.restoreAdjusted(sourceOwner: owner, using: self, for: self.restoration)
        self.adjustRemainingUses(by: -1)
    }
    
    func isStackable(with consumable: Consumable) -> Bool {
        if let consumable = consumable as? Self {
            return consumable.restoration == self.restoration && consumable.restorationIncrease == self.restorationIncrease
        }
        return false
    }
    
    func onTurnEnd(player: Player, playerUsed: Item?, foe: Foe?) {
        self.adjustRestoration(by: self.restorationIncrease)
    }
    
    override func restorationDidSet() {
        self.setEffectsDescription(to: Strings("consumable.turnImprovingRestoration.effectsDescription2Param").localWithArgs(self.restoration, self.restorationIncrease))
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerHealthRestorationStat.getValue(amount: self.startingRestoration + self.restorationIncrease*10, uses: self.remainingUses)
    }

}
