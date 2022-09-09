//
//  Consumable.swift
//  yonder
//
//  Created by Andre Pham on 7/9/2022.
//

import Foundation

typealias ConsumableAbstract = ConsumableAbstractPart & EffectsDescribed & AlwaysUsable & ConsumableIsStackable

class ConsumableAbstractPart: Named, Described, Clonable, Purchasable {
    
    private(set) var name: String
    private(set) var description: String
    private(set) var stack = 1 {
        didSet {
            if self.stack <= 0 {
                OnNoConsumablesRemainingPublisher.publish(consumable: self as! ConsumableAbstract)
            }
        }
    }
    public let basePurchasePrice: Int
    public let id = UUID()
    
    init(name: String, description: String, basePurchasePrice: Int) {
        self.name = name
        self.description = description
        self.basePurchasePrice = basePurchasePrice
    }
    
    required init(_ original: ConsumableAbstractPart) {
        self.name = original.name
        self.description = original.description
        self.basePurchasePrice = original.basePurchasePrice
        self.stack = original.stack
    }
    
    func adjustStack(by amount: Int) {
        self.stack += amount
    }
    
    func getPurchaseInfo() -> PurchasableItemInfo {
        return PurchasableItemInfo(name: self.name, description: self.description, type: .consumable)
    }
    
    func beReceived(by receiver: Player, amount: Int) {
        if amount > 1 {
            self.stack *= amount
        }
        receiver.addConsumable(self as! ConsumableAbstract)
    }
    
    func updateNameAndDescription(name: String, description: String) {
        self.name = name
        self.description = description
    }
    
}
