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
    
    init(_ friendly: Friendly) {
        self.offers = friendly.offers.map { OfferViewModel($0) }
        
        super.init(friendly)
    }
    
    func acceptOffer(_ offerViewModel: OfferViewModel, player: PlayerViewModel) {
        (self.interactor as! Friendly).acceptOffer(offerViewModel.offer, for: player.player)
    }
    
}
