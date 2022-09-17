//
//  TurnImprovingRestoration.swift
//  yonder
//
//  Created by Andre Pham on 7/9/2022.
//

import Foundation

class TurnImprovingRestoration: ConsumableAbstract, OnTurnEndSubscriber {
    
    /// The amount of restoration this consumable starts with
    private let startingRestoration = 10
    /// The amount of restoration this improves by every turn
    private let restorationIncrease = 2
    
    init(basePurchasePrice: Int) {
        super.init(
            name: Strings.Consumable.TurnImprovingRestoration.Name.local,
            description: Strings.Consumable.TurnImprovingRestoration.Description.local,
            effectsDescription: Strings.Consumable.TurnImprovingRestoration.EffectsDescription2Param.localWithArgs(self.startingRestoration, self.restorationIncrease),
            basePurchasePrice: basePurchasePrice,
            restoration: self.startingRestoration
        )
        
        OnTurnEndPublisher.subscribe(self)
    }
    
    required init(_ original: ConsumableAbstractPart) {
        let original = original as! Self
        super.init(
            name: original.name,
            description: original.description,
            effectsDescription: original.effectsDescription,
            basePurchasePrice: original.basePurchasePrice,
            restoration: original.restoration
        )
        
        OnTurnEndPublisher.subscribe(self)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract?) {
        owner.restoreAdjusted(sourceOwner: owner, using: self, for: self.restoration)
        self.adjustRemainingUses(by: -1)
    }
    
    func isStackable(with consumable: ConsumableAbstract) -> Bool {
        if let consumable = consumable as? Self {
            return consumable.restoration == self.restoration && consumable.restorationIncrease == self.restorationIncrease
        }
        return false
    }
    
    func onTurnEnd(player: Player, playerUsed: ItemAbstract?, foe: Foe?) {
        self.adjustRestoration(by: self.restorationIncrease)
    }
    
    override func restorationDidSet() {
        self.setEffectsDescription(to: Strings.Consumable.TurnImprovingRestoration.EffectsDescription2Param.localWithArgs(self.restoration, self.restorationIncrease))
    }

}
