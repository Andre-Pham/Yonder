//
//  Potion.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

typealias Potion = PotionAbstract & Usable & HasPurchasablePrice

class PotionAbstract: Item, Purchasable, Clonable {
    
    private let effectsDescription: String?
    var potionCount: Int {
        return self.remainingUses
    }
    
    init(name: String, description: String, effectsDescription: String?, remainingUses: Int = 0, damage: Int = 0, restoration: Int = 0, healthRestoration: Int = 0, armorPointsRestoration: Int = 0) {
        self.effectsDescription = effectsDescription
        
        super.init(name: name, description: description, remainingUses: remainingUses, damage: damage, restoration: restoration, healthRestoration: healthRestoration, armorPointsRestoration: armorPointsRestoration)
    }
    
    required init(_ original: PotionAbstract) {
        self.effectsDescription = original.effectsDescription
        
        super.init(name: original.name, description: original.description, remainingUses: original.remainingUses, damage: original.damage, restoration: original.restoration, healthRestoration: original.healthRestoration, armorPointsRestoration: original.armorPointsRestoration, infiniteRemainingUses: original.infiniteRemainingUses)
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
    
    func getEffectsDescription() -> String? {
        return self.effectsDescription
    }
    
    func isStackable(with potion: Potion) -> Bool {
        return self.damage == potion.damage && self.healthRestoration == potion.healthRestoration && self.armorPointsRestoration == potion.armorPointsRestoration && self.name == potion.name && self.description == potion.description
    }
    
    func getPurchaseInfo() -> PurchasableItemInfo {
        return PurchasableItemInfo(name: "\(self.name) (x\(self.remainingUses))", description: self.description, type: .potion)
    }
    
    func beReceived(by receiver: Player, amount: Int) {
        for _ in 0..<amount {
            receiver.addPotion(self as! Potion)
        }
    }
    
    override func remainingUsesDidSet() {
        if self.remainingUses == 0 {
            OnNoPotionsRemainingPublisher.publish(potion: self as! Potion)
        }
    }
    
    func getBasePurchasePrice() -> Int {
        return (self as! Potion).calculateBasePurchasePrice()
    }
    
}
