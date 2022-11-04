//
//  TravelImprovingRestorationConsumable.swift
//  yonder
//
//  Created by Andre Pham on 7/9/2022.
//

import Foundation

class TravelImprovingRestorationConsumable: Consumable, OnPlayerTravelSubscriber {
    
    /// The amount of restoration this consumable starts with
    private let startingRestoration = 10
    /// The amount of restoration this improves by every travel
    private let restorationIncrease = 8
    
    init() {
        super.init(
            name: Strings("consumable.travelImprovingRestoration.name").local,
            description: Strings("consumable.travelImprovingRestoration.description").local,
            effectsDescription: Strings("consumable.travelImprovingRestoration.effectsDescription2Param").localWithArgs(self.startingRestoration, self.restorationIncrease),
            restoration: self.startingRestoration
        )
        
        OnPlayerTravelPublisher.subscribe(self)
    }
    
    required init(_ original: ConsumableAbstract) {
        let original = original as! Self
        super.init(
            name: original.name,
            description: original.description,
            effectsDescription: original.effectsDescription,
            restoration: original.restoration
        )
        
        OnPlayerTravelPublisher.subscribe(self)
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
    
    func onPlayerTravel(player: Player, newLocation: Location) {
        self.adjustRestoration(by: self.restorationIncrease)
    }
    
    override func restorationDidSet() {
        self.setEffectsDescription(to: Strings("consumable.travelImprovingRestoration.effectsDescription2Param").localWithArgs(self.restoration, self.restorationIncrease))
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerHealthRestorationStat.getValue(amount: self.startingRestoration + self.restorationIncrease*10, uses: self.remainingUses)
    }

}
