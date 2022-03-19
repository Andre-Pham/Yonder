//
//  OfferViewModel.swift
//  yonder
//
//  Created by Andre Pham on 13/3/2022.
//

import Foundation

class OfferViewModel {
    
    // offer can be used within the ViewModel layer, but Views should only interact with ViewModels (not the Model layer)
    private(set) var offer: Offer
    @Published private(set) var name: String
    @Published private(set) var description: String
    private(set) var id: UUID
    
    init(_ offer: Offer) {
        self.offer = offer
        
        // Set properties to match Offer
        
        self.name = self.offer.name
        self.description = self.offer.description
        self.id = self.offer.id
    }
    
    func accept(playerViewModel: PlayerViewModel) {
        self.offer.acceptOffer(player: playerViewModel.player)
    }
    
}
