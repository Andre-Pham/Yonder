//
//  Friendly.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class Friendly {
    
    private(set) var offers: [Offer]
    private(set) var offersAccepted: Int
    private(set) var offerLimit: Int
    
    init(offers: [Offer], offersAccepted: Int, offerLimit: Int) {
        self.offers = offers
        self.offersAccepted = offersAccepted
        self.offerLimit = offerLimit
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
            self.offers = []
        }
    }
    
}
