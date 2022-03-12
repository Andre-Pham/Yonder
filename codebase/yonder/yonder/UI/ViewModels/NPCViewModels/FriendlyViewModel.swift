//
//  FriendlyViewModel.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import Foundation
import Combine

class FriendlyViewModel: InteractorViewModel {
    
    @Published private(set) var offers: [OfferViewModel]
    @Published private(set) var offersRemaining: Int
    
    init(_ friendly: Friendly) {
        // Set properties to match Friendly
        self.offersRemaining = friendly.offersRemaining
        
        // Set other view models
        self.offers = friendly.offers.map { OfferViewModel($0) }
        
        super.init(friendly)
        
        // Add Subscribers
        
        friendly.$offersAccepted.sink(receiveValue: { _ in
            self.offersRemaining = friendly.offersRemaining
        }).store(in: &self.subscriptions)
    }
    
    func acceptOffer(_ offerViewModel: OfferViewModel, player: PlayerViewModel) {
        (self.interactor as! Friendly).acceptOffer(offerViewModel.offer, for: player.player)
    }
    
}
