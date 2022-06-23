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
                YonderText(text: Strings.Card.LowestPriceShorthand.local.rightPadded(by: ": "), size: .cardSubscript)
                
                YonderIconNumeralPair(prefix: Strings.CurrencySymbol.local, image: YonderImages.goldIcon, numeral: self.minPrice, size: .cardSubscript, iconSize: .cardSubscript)
            }
            
            YonderTextNumeralHStack {
                YonderText(text: Strings.Card.HighestPriceShorthand.local.rightPadded(by: ": "), size: .cardSubscript)
                
                YonderIconNumeralPair(prefix: Strings.CurrencySymbol.local, image: YonderImages.goldIcon, numeral: self.maxPrice, size: .cardSubscript, iconSize: .cardSubscript)
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
