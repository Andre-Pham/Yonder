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
            return YonderColors.lowerIndicative
        } else if indicativePrice > self.price {
            return YonderColors.higherIndicative
        }
        return YonderColors.textMaxContrast
    }
    
    var body: some View {
        YonderBorder6 {
            ZStack {
                if let indicativePrice = indicativePrice {
                    YonderIconNumeralPair(prefix: Strings("currencySymbol").local, image: YonderIcons.goldIcon, numeral: indicativePrice, size: .buttonBody, color: self.indicativeColor)
                } else {
                    YonderIconNumeralPair(prefix: Strings("currencySymbol").local, image: YonderIcons.goldIcon, numeral: self.price, size: .buttonBody)
                }
            }
            .padding(.horizontal, YonderCoreGraphics.padding*1.5)
            .padding(.vertical, YonderCoreGraphics.padding)
        }
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
