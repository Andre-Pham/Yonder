//
//  RestorerCardView.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import Foundation
import SwiftUI

struct RestorerCardView: View {
    @ObservedObject var restorerViewModel: RestorerViewModel
    
    var body: some View {
        CardBody(name: self.restorerViewModel.name) {
            CardInteractorTypeView()
            
            ForEach(self.restorerViewModel.options, id: \.id) { option in
                YonderTextNumeralHStack {
                    YonderIconNumeralPair(image: option.getImage(), numeral: Restorer.bundleSize, size: .cardSubscript, iconSize: .cardSubscript)
                    
                    YonderText(text: " / ", size: .cardSubscript)
                    
                    YonderIconNumeralPair(prefix: "$", image: YonderImages.goldIcon, numeral: option.getBundlePrice(), size: .cardSubscript, iconSize: .cardSubscript)
                }
            }
        }
    }
}

struct RestorerCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            RestorerCardView(restorerViewModel: RestorerViewModel(Restorer(
                name: "Mercy",
                description: "Heroes never die!",
                options: [.health, .armorPoints],
                pricePerHealthBundle: 10,
                pricePerArmorPointBundle: 10)))
        }
    }
}
