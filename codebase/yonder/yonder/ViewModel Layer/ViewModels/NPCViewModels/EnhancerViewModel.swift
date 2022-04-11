//
//  EnhancerViewModel.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import Foundation
import Combine

class EnhancerViewModel: InteractorViewModel {
    
    @Published private(set) var enhanceOfferViewModels = [EnhanceOfferViewModel]()
    
    init(_ enhancer: Enhancer) {
        super.init(enhancer)
        
        for enhanceOffer in enhancer.enhanceOffers {
            self.enhanceOfferViewModels.append(EnhanceOfferViewModel(enhanceOffer))
        }
    }
    
}
