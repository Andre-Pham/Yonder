//
//  TurnImprovingRestoration.swift
//  yonder
//
//  Created by Andre Pham on 7/9/2022.
//

import Foundation

class TurnImprovingRestoration: ConsumableAbstract, OnTurnEndSubscriber {
    
    /// The amount this restores
    private var restoration = 10
    /// The amount of restoration this improves by every turn
    private let restorationIncrease = 2
    
    init(basePurchasePrice: Int) {
        super.init(
            name: Strings.Consumable.TurnImprovingRestoration.Name.local,
            description: Strings.Consumable.TurnImprovingRestoration.Description.local,
            basePurchasePrice: basePurchasePrice
        )
        
        OnTurnEndPublisher.subscribe(self)
    }
    
    required init(_ original: ConsumableAbstractPart) {
        let original = original as! Self
        self.restoration = original.restoration
        super.init(original)
        
        OnTurnEndPublisher.subscribe(self)
    }
    
    func getEffectsDescription() -> String? {
        return Strings.Consumable.TurnImprovingRestoration.EffectsDescription2Param.localWithArgs(self.restoration, self.restorationIncrease)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract?) {
        owner.restoreAdjusted(sourceOwner: owner, using: self, for: self.restoration)
    }
    
    func isStackable(with consumable: ConsumableAbstract) -> Bool {
        if let consumable = consumable as? Self {
            return consumable.restoration == self.restoration && consumable.restorationIncrease == self.restorationIncrease
        }
        return false
    }
    
    func onTurnEnd(player: Player, playerUsed: ItemAbstract?, foe: Foe?) {
        self.restoration += self.restorationIncrease
    }

}
