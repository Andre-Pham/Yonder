//
//  ShopKeeper.swift
//  yonder
//
//  Created by Andre Pham on 2/12/21.
//

import Foundation

class ShopKeeper: InteractorAbstract {
    
    @DidSetPublished private(set) var purchasableItems: [PurchasableItem]
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", purchasableItems: [PurchasableItem]) {
        self.purchasableItems = purchasableItems
        
        super.init(name: name, description: description)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case purchasableItems
    }

    required init(dataObject: DataObject) {
        self.purchasableItems = dataObject.getObjectArray(Field.purchasableItems.rawValue, type: PurchasableItem.self)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.purchasableItems.rawValue, value: self.purchasableItems)
    }

    // MARK: - Functions
    
    func purchaseItem(_ item: PurchasableItem, amount: Int, purchaser: Player) {
        if let index = self.purchasableItems.firstIndex(where: { item.id == $0.id }) {
            self.purchaseItem(at: index, amount: amount, purchaser: purchaser)
        }
    }
    
    func purchaseItem(at index: Int, amount: Int, purchaser: Player) {
        self.purchasableItems[index].purchase(amount: amount, purchaser: purchaser)
        if self.purchasableItems[index].stockRemaining == 0 {
            self.purchasableItems.remove(at: index)
        }
    }
    
}
