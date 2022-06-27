//
//  PriceTagView.swift
//  yonder
//
//  Created by Andre Pham on 6/5/2022.
//

import SwiftUI

struct PriceTagView: View {
    let price: Int
    var indicativePrice: Int? = nil
    private var indicativeColor: Color {
        guard let indicativePrice = self.indicativePrice else {
            return YonderColors.textMaxContrast
        }
        if indicativePrice < self.price {
            return YonderColors.negativeRed
        } else if indicativePrice > self.price {
            return YonderColors.highlight
        }
        return YonderColors.textMaxContrast
    }
    
    var body: some View {
        ZStack {
            if let indicativePrice = indicativePrice {
                YonderIconNumeralPair(prefix: Strings.CurrencySymbol.local, image: YonderImages.goldIcon, numeral: indicativePrice, size: .buttonBody, color: self.indicativeColor)
            } else {
                YonderIconNumeralPair(prefix: Strings.CurrencySymbol.local, image: YonderImages.goldIcon, numeral: self.price, size: .buttonBody)
            }
        }
        .padding(.horizontal, YonderCoreGraphics.padding*1.5)
        .padding(.vertical, YonderCoreGraphics.padding)
        .border(YonderColors.border, width: YonderCoreGraphics.borderWidth)
    }
}

struct PriceTagView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            VStack {
                PriceTagView(price: 100)
                
                PriceTagView(price: 100, indicativePrice: 200)
            }
        }
    }
}
