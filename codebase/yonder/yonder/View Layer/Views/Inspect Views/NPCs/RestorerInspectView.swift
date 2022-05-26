//
//  RestorerInspectView.swift
//  yonder
//
//  Created by Andre Pham on 9/5/2022.
//

import SwiftUI

struct RestorerInspectView: View {
    @ObservedObject var restorerViewModel: RestorerViewModel
    
    var body: some View {
        InspectNPCBody(
            name: self.restorerViewModel.name,
            description: self.restorerViewModel.description,
            locationType: LocationType.restorer
        ) {
            YonderText(text: "Restore Options", size: .inspectSheetTitle)
            
            ForEach(self.restorerViewModel.options, id: \.id) { option in
                YonderTextNumeralHStack {
                    YonderText(text: "■ Restore ", size: .inspectSheetBody)
                    
                    YonderIconNumeralPair(image: option.getImage(), numeral: Restorer.bundleSize, size: .inspectSheetBody, iconSize: .inspectSheet)
                    
                    YonderText(text: " for ", size: .inspectSheetBody)
                    
                    YonderIconNumeralPair(prefix: "$", image: YonderImages.goldIcon, numeral: option.getBundlePrice(), size: .inspectSheetBody, iconSize: .inspectSheet)
                }
            }
        }
    }
}

struct RestorerInspectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            RestorerInspectView(restorerViewModel: RestorerViewModel(Restorer(
                name: "Mercy",
                description: "Heroes never die!",
                options: [.health, .armorPoints],
                pricePerHealthBundle: 10,
                pricePerArmorPointBundle: 10)))
        }
    }
}
