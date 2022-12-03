//
//  CardPriceRangeView.swift
//  yonder
//
//  Created by Andre Pham on 8/5/2022.
//

import SwiftUI

struct CardPriceRangeView: View {
    let minPrice: Int
    let maxPrice: Int
    
    var body: some View {
        Group {
            YonderTextNumeralHStack {
                YonderText(text: Strings("card.lowestPriceShorthand").local.rightPadded(by: ": "), size: .cardSubscript)
                
                YonderIconNumeralPair(prefix: Strings("currencySymbol").local, image: YonderIcons.goldIcon, numeral: self.minPrice, size: .cardSubscript, iconSize: .cardSubscript)
            }
            
            YonderTextNumeralHStack {
                YonderText(text: Strings("card.highestPriceShorthand").local.rightPadded(by: ": "), size: .cardSubscript)
                
                YonderIconNumeralPair(prefix: Strings("currencySymbol").local, image: YonderIcons.goldIcon, numeral: self.maxPrice, size: .cardSubscript, iconSize: .cardSubscript)
            }
        }
    }
}

struct CardPriceRangeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            VStack {
                CardPriceRangeView(minPrice: 100, maxPrice: 1000)
            }
        }
    }
}
