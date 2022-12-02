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
    
    init(amount: Int) {
        super.init(
            name: Strings("consumable.travelImprovingRestoration.name").local,
            description: Strings("consumable.travelImprovingRestoration.description").local,
            effectsDescription: Strings("consumable.travelImprovingRestoration.effectsDescription2Param").localWithArgs(self.startingRestoration, self.restorationIncrease),
            remainingUses: amount,
            restoration: self.startingRestoration
        )
        
        OnPlayerTravelPublisher.subscribe(self)
    }
    
    required init(_ original: ConsumableAbstract) {
        let original = original as! Self
        super.init(original)
        
        OnPlayerTravelPublisher.subscribe(self)
    }
    
    // MARK: - Serialisation
    
    required init(dataObject: DataObject) {
        super.init(dataObject: dataObject)
        
        OnPlayerTravelPublisher.subscribe(self)
    }
    
    override func toDataObject() -> DataObject {
        return super.toDataObject()
    }
    
    // MARK: - Functions
    
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
