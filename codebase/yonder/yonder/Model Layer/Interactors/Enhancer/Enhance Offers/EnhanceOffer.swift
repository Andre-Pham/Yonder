//
//  EnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 8/4/2022.
//

import Foundation

typealias EnhanceOffer = EnhanceOfferAbstract & EnhanceOfferProtocol

protocol EnhanceOfferProtocol {
    
    func getEnhanceables(from player: Player) -> [Enhanceable]
    func acceptOffer(player: Player, enhanceableID: UUID)
    
}

class EnhanceOfferAbstract: Named, Described, Storable {
    
    public let id = UUID()
    public let price: Int
    public let name: String
    public let description: String
    
    init(price: Int, name: String, description: String) {
        self.price = price
        self.name = name
        self.description = description
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case price
        case name
        case description
    }

    required init(dataObject: DataObject) {
        self.price = dataObject.get(Field.price.rawValue)
        self.name = dataObject.get(Field.name.rawValue)
        self.description = dataObject.get(Field.description.rawValue)
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.price.rawValue, value: self.price)
            .add(key: Field.name.rawValue, value: self.name)
            .add(key: Field.description.rawValue, value: self.description)
    }

    // MARK: - Functions
    
    func canBePurchased(price: Int, purchaser: Player) -> Bool {
        let adjustedPrice = BuffApps.getAdjustedPrice(purchaser: purchaser, price: price)
        return adjustedPrice <= purchaser.gold
    }
    
}
