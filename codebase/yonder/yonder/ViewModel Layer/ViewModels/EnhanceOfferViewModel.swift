//
//  EnhanceOfferViewModel.swift
//  yonder
//
//  Created by Andre Pham on 11/4/2022.
//

import Foundation

class EnhanceOfferViewModel {
    
    // offer can be used within the ViewModel layer, but Views should only interact with ViewModels (not the Model layer)
    private(set) var offer: EnhanceOffer
    @Published private(set) var name: String
    @Published private(set) var description: String
    private(set) var id: UUID
    
    init(_ offer: EnhanceOffer) {
        self.offer = offer
        
        // Set properties to match EnhanceOffer
        
        self.name = self.offer.name
        self.description = self.offer.description
        self.id = self.offer.id
    }
    
    func accept(playerViewModel: PlayerViewModel, enhanceableID: UUID) {
        self.offer.acceptOffer(player: playerViewModel.player, enhanceableID: enhanceableID)
    }
    
}

