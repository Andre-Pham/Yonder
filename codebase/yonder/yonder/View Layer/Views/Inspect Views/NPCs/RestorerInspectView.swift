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
            YonderText(text: Strings.Inspect.Title.RestoreOptions.local, size: .inspectSheetTitle)
            
            ForEach(self.restorerViewModel.options, id: \.id) { option in
                YonderTextNumeralHStack {
                    YonderText(text: "■" + option.actionDescription.padded(by: " "), size: .inspectSheetBody)
                    
                    YonderIconNumeralPair(image: option.image, numeral: Restorer.bundleSize, size: .inspectSheetBody, iconSize: .inspectSheet)
                    
                    YonderText(text: Strings.Inspect.Restorer.For.local.padded(by: " "), size: .inspectSheetBody)
                    
                    YonderIconNumeralPair(prefix: Strings.CurrencySymbol.local, image: YonderImages.goldIcon, numeral: option.getBundlePrice(), size: .inspectSheetBody, iconSize: .inspectSheet)
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
            
            RestorerInspectView(restorerViewModel: PreviewObjects.restorerViewModel)
        }
    }
}
