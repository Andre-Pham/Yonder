//
//  EnhancerCardView.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import Foundation
import SwiftUI

struct EnhancerCardView: View {
    @ObservedObject var enhancerViewModel: EnhancerViewModel
    
    var body: some View {
        CardBody(name: self.enhancerViewModel.name) {
            CardInteractorTypeView()
            
            CardPriceRangeView(
                minPrice: self.enhancerViewModel.getLowestPrice(),
                maxPrice: self.enhancerViewModel.getHighestPrice())
            
            CardOfferCountView(offerCount: self.enhancerViewModel.enhanceOfferViewModels.count)
        }
    }
}

struct EnhancerCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            EnhancerCardView(enhancerViewModel: EnhancerViewModel(Enhancer(
                name: "Ana",
                description: "You're powered up, get in there!",
                offers: [WeaponDamageEnhanceOffer(price: 100, damage: 200)])))
        }
    }
}
