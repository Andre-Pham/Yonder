//
//  Friendly.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class Friendly: InteractorAbstract {
    
    private(set) var offers: [Offer]
    private(set) var offersAccepted = 0 // How many offers has the user already accepted
    private(set) var offerLimit: Int // How many offers can be accepted until the user must stop
    
    init(name: String = "placeholderName", description: String = "placerholderDescription", offers: [Offer], offerLimit: Int) {
        self.offers = offers
        self.offerLimit = offerLimit
        
        super.init(name: name, description: description)
    }
    
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
        if self.offersAccepted == self.offerLimit {
            self.offers.removeAll()
        }
    }
    
}
