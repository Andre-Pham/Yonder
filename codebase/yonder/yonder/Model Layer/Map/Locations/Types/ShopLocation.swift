//
//  ShopLocation.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class ShopLocation: Location {
    
    private(set) var shopKeeper: ShopKeeper
    public let type: LocationType = .shop
    
    init(shopKeeper: ShopKeeper) {
        self.shopKeeper = shopKeeper
        super.init()
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case shopKeeper
    }

    required init(dataObject: DataObject) {
        self.shopKeeper = dataObject.getObject(Field.shopKeeper.rawValue, type: ShopKeeper.self)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.shopKeeper.rawValue, value: self.shopKeeper)
    }
    
}
