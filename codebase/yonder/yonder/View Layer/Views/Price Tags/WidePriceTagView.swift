//
//  WidePriceTagView.swift
//  yonder
//
//  Created by Andre Pham on 6/5/2022.
//

import SwiftUI

struct WidePriceTagView: View {
    let price: Int
    var indicativePrice: Int? = nil
    var text: String = ""
    var displayText: String {
        return self.text.isEmpty ? "" : " " + self.text
    }
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
        YonderBorder8 {
            ZStack {
                if let indicativePrice = self.indicativePrice {
                    YonderTextNumeralHStack {
                        YonderIconNumeralPair(prefix: Strings("currencySymbol").local, image: YonderIcons.goldIcon, numeral: indicativePrice, size: .buttonBody, color: self.indicativeColor)
                        
                        YonderText(text: self.displayText, size: .buttonBody)
                    }
                } else {
                    YonderIconNumeralPair(prefix: Strings("currencySymbol").local, suffix: self.displayText, image: YonderIcons.goldIcon, numeral: self.price, size: .buttonBody)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 18)
            .padding(.vertical, 14)
        }
    }
}

struct WidePriceTagView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            VStack {
                WidePriceTagView(price: 100, text: "Each")
                
                WidePriceTagView(price: 100, indicativePrice: 200, text: "Each")
            }
        }
    }
}
