//
//  Consumable.swift
//  yonder
//
//  Created by Andre Pham on 14/9/2022.
//

import Foundation

typealias Consumable = ConsumableAbstract & AlwaysUsable & ConsumableIsStackable & HasPurchasablePrice

class ConsumableAbstract: Item, Clonable, Purchasable {
    
    let triggersEndOfTurn = false
    @DidSetPublished private(set) var effectsDescription: String? = nil
    
    init(name: String, description: String, effectsDescription: String?, requiresFoeForUsage: Bool = false, remainingUses: Int, damage: Int = 0, restoration: Int = 0, healthRestoration: Int = 0, armorPointsRestoration: Int = 0) {
        self.effectsDescription = effectsDescription
        super.init(name: name, description: description, remainingUses: remainingUses, damage: damage, restoration: restoration, healthRestoration: healthRestoration, armorPointsRestoration: armorPointsRestoration, requiresFoeForUsage: requiresFoeForUsage)
    }
    
    required init(_ original: ConsumableAbstract) {
        self.effectsDescription = original.effectsDescription
        super.init(name: original.name, description: original.description, remainingUses: original.remainingUses, damage: original.damage, restoration: original.restoration, healthRestoration: original.healthRestoration, armorPointsRestoration: original.armorPointsRestoration, requiresFoeForUsage: original.requiresFoeForUsage)
    }
    
    // MARK: - Serialisation
    
    private enum Field: String {
        case effectsDescription
    }
    
    required init(dataObject: DataObject) {
        self.effectsDescription = dataObject.get(Field.effectsDescription.rawValue)
        super.init(dataObject: dataObject)
    }
    
    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.effectsDescription.rawValue, value: self.effectsDescription)
    }
    
    // MARK: - Functions
    
    func setEffectsDescription(to effectsDescription: String) {
        self.effectsDescription = effectsDescription
    }
    
    func getPurchaseInfo() -> PurchasableItemInfo {
        return PurchasableItemInfo(name: "\(self.name) (x\(self.remainingUses))", description: self.description, type: .consumable)
    }
    
    func beReceived(by receiver: Player, amount: Int) {
        if amount > 1 {
            self.setRemainingUses(to: self.remainingUses*amount)
        }
        receiver.addConsumable(self as! Consumable)
    }
    
    func getBasePurchasePrice() -> Int {
        return (self as! Consumable).calculateBasePurchasePrice()
    }
    
    func getEffectsDescription() -> String? {
        return self.effectsDescription
    }
    
    override func remainingUsesDidSet() {
        if self.remainingUses <= 0 {
            OnNoConsumablesRemainingPublisher.publish(consumable: self as! Consumable)
        }
    }
    
}
