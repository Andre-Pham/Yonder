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
        CardBody {
            CardNPCTypeView()
            
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
            
            EnhancerCardView(enhancerViewModel: PreviewObjects.enhancerViewModel)
        }
    }
}
