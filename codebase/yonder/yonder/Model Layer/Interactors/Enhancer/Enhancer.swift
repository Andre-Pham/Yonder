//
//  Enhancer.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class Enhancer: InteractorAbstract {
    
    public let enhanceOffers: [EnhanceOffer]
    
    init(name: String = "placeholderName", description: String = "placerholderDescription", offers: [EnhanceOffer]) {
        self.enhanceOffers = offers
        
        super.init(name: name, description: description)
    }
    
}
