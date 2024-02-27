//
//  OfferViewModel.swift
//  yonder
//
//  Created by Andre Pham on 13/3/2022.
//

import Foundation

class OfferViewModel: ObservableObject {
    
    // offer can be used within the ViewModel layer, but Views should only interact with ViewModels (not the Model layer)
    private(set) var offer: Offer
    private(set) var name: String
    private(set) var description: String
    private(set) var id: UUID
    
    init(_ offer: Offer) {
        self.offer = offer
        
        // Set properties to match Offer
        
        self.name = self.offer.name
        self.description = self.offer.description
        self.id = self.offer.id
    }
    
    func accept(playerViewModel: PlayerViewModel) {
        guard self.canBeAccepted(playerViewModel: playerViewModel) else {
            return
        }
        self.offer.acceptOffer(player: playerViewModel.player)
    }
    
    func canBeAccepted(playerViewModel: PlayerViewModel) -> Bool {
        return self.offer.meetsOfferRequirements(player: playerViewModel.player)
    }
    
}
