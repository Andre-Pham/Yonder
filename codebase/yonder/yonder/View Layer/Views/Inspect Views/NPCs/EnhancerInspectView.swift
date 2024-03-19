//
//  EnhancerInspectView.swift
//  yonder
//
//  Created by Andre Pham on 9/5/2022.
//

import SwiftUI

struct EnhancerInspectView: View {
    @ObservedObject var enhancerViewModel: EnhancerViewModel
    
    var body: some View {
        InspectNPCBody(
            name: self.enhancerViewModel.name,
            description: self.enhancerViewModel.description,
            locationType: LocationType.enhancer
        ) {
            YonderText(text: Strings("inspect.title.offers").local, size: .inspectSheetTitle)
            
            ForEach(self.enhancerViewModel.enhanceOfferViewModels, id: \.id) { offer in
                YonderBorder4 {
                    VStack(alignment: .leading, spacing: 0) {
                        YonderText(text: offer.name, size: .inspectSheetBody)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(YonderBorder4Presets.outlineColor)
                        
                        YonderBorder4Presets.outlineColor
                            .frame(height: YonderBorder4Presets.outlineThickness)
                            .padding(.vertical, 6.0)
                            .padding(.horizontal, -YonderCoreGraphics.innerPadding)
                        
                        YonderText(text: offer.description, size: .inspectSheetBody)
                        
                        YonderIconTextPair(
                            image: YonderIcons.goldIcon,
                            text: Strings("currencySymbol").local + "\(offer.price)",
                            size: .inspectSheetBody,
                            iconSize: .inspectSheet
                        )
                        .padding(.top, 6.0)
                    }
                    .padding(YonderCoreGraphics.innerPadding)
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

struct EnhancerInspectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            EnhancerInspectView(enhancerViewModel: PreviewObjects.enhancerViewModel)
        }
    }
}
