//
//  Offer.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

protocol Offer {
    
    var id: UUID { get }
    
    func acceptOffer(player: Player)
    
}
