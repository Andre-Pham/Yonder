//
//  PurchasableItemInfo.swift
//  yonder
//
//  Created by Andre Pham on 11/4/2022.
//

import Foundation

class PurchasableItemInfo {
    
    public let name: String
    public let description: String
    public let type: PurchasableItem.PurchasableItemType
    
    init(name: String, description: String, type: PurchasableItem.PurchasableItemType) {
        self.name = name
        self.description = description
        self.type = type
    }
    
}
