//
//  Offer.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

typealias Offer = OfferAbstract & OfferProtocol

protocol OfferProtocol {
    
    func acceptOffer(player: Player)
    func meetsOfferRequirements(player: Player) -> Bool
    
}

class OfferAbstract: Named, Described, Storable {
    
    public let name: String
    public let description: String
    public let id: UUID = UUID()
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
    
    // MARK: - Serialisation
    
    private enum Field: String {
        case name
        case description
    }

    required init(dataObject: DataObject) {
        self.name = dataObject.get(Field.name.rawValue)
        self.description = dataObject.get(Field.description.rawValue)
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.name.rawValue, value: self.name)
            .add(key: Field.description.rawValue, value: self.description)
    }
    
}
