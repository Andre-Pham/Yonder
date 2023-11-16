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
        CardBody {
            CardNPCTypeView()
            
            ForEach(self.restorerViewModel.options, id: \.id) { option in
                YonderTextNumeralHStack {
                    YonderIconNumeralPair(image: option.image, numeral: Restorer.bundleSize, size: .cardSubscript, iconSize: .cardSubscript)
                    
                    YonderText(text: " / ", size: .cardSubscript)
                    
                    YonderIconNumeralPair(prefix: Strings("currencySymbol").local, image: YonderIcons.goldIcon, numeral: option.getBundlePrice(), size: .cardSubscript, iconSize: .cardSubscript)
                }
            }
        }
    }
}

struct RestorerCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            RestorerCardView(restorerViewModel: PreviewObjects.restorerViewModel)
        }
    }
}
