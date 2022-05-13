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
    
    func getOffersDescription() -> String {
        var description = ""
        let names = self.enhanceOfferViewModels.map { $0.name }
        for name in names {
            if !description.isEmpty {
                description += ", "
            }
            description += name
        }
        return description
    }
    
    func getHighestPrice() -> Int {
        return self.enhanceOfferViewModels.sorted { $0.price > $1.price }.first?.price ?? 0
    }
    
    func getLowestPrice() -> Int {
        return self.enhanceOfferViewModels.sorted { $0.price < $1.price }.first?.price ?? 0
    }
    
}
