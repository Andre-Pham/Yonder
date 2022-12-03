//
//  Friendly.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class Friendly: InteractorAbstract {
    
    private(set) var offers: [Offer]
    @DidSetPublished private(set) var offersAccepted = 0 // How many offers has the user already accepted
    private(set) var offerLimit: Int // How many offers can be accepted until the user must stop
    var offersRemaining: Int {
        return self.offerLimit - self.offersAccepted
    }
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", offers: [Offer], offerLimit: Int) {
        self.offers = offers
        self.offerLimit = offerLimit
        
        super.init(name: name, description: description)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case offers
        case offersAccepted
        case offerLimit
    }

    required init(dataObject: DataObject) {
        self.offers = dataObject.getObjectArray(Field.offers.rawValue, type: OfferAbstract.self) as! [any Offer]
        self.offersAccepted = dataObject.get(Field.offersAccepted.rawValue)
        self.offerLimit = dataObject.get(Field.offerLimit.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.offers.rawValue, value: self.offers as [OfferAbstract])
            .add(key: Field.offersAccepted.rawValue, value: self.offersAccepted)
            .add(key: Field.offerLimit.rawValue, value: self.offerLimit)
    }

    // MARK: - Functions
    
    func removeOffer(_ offer: Offer) {
        guard let index = (self.offers.firstIndex { $0.id == offer.id }) else {
            return
        }
        self.offers.remove(at: index)
    }
    
    func acceptOffer(_ offer: Offer, for player: Player) {
        offer.acceptOffer(player: player)
        self.removeOffer(offer)
        self.offersAccepted += 1
        if self.offersRemaining == 0 {
            self.offers.removeAll()
        }
    }
    
}
