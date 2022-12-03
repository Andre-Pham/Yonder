//
//  Enhancer.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class Enhancer: InteractorAbstract {
    
    public let enhanceOffers: [EnhanceOffer]
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", offers: [EnhanceOffer]) {
        self.enhanceOffers = offers
        
        super.init(name: name, description: description)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case enhanceOffers
    }

    required init(dataObject: DataObject) {
        self.enhanceOffers = dataObject.getObjectArray(Field.enhanceOffers.rawValue, type: EnhanceOfferAbstract.self) as! [any EnhanceOffer]
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.enhanceOffers.rawValue, value: self.enhanceOffers as [EnhanceOfferAbstract])
    }
    
}
