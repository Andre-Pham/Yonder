//
//  Offer.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

protocol Offer: Named, Described {
    
    var id: UUID { get }
    
    func acceptOffer(player: Player)
    func meetsOfferRequirements(player: Player) -> Bool
    static func build(stage: Int) -> Offer
    
}
