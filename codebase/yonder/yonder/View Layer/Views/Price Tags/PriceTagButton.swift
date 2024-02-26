//
//  PriceTagButton.swift
//  yonder
//
//  Created by Andre Pham on 26/2/2024.
//

import SwiftUI

struct PriceTagButton: View {
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
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
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
}

#Preview {
    PreviewContentView {
        VStack {
            PriceTagButton(price: 100) {
                // Do something
            }
            
            PriceTagButton(price: 100, indicativePrice: 200) {
                // Do something
            }
        }
    }
}
