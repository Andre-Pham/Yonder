//
//  WidePriceTagButton.swift
//  yonder
//
//  Created by Andre Pham on 26/2/2024.
//

import SwiftUI

struct WidePriceTagButton: View {
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
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            YonderBorder6 {
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
                .padding(.horizontal, YonderCoreGraphics.padding*1.5)
                .padding(.vertical, YonderCoreGraphics.padding)
            }
        }
    }
}

#Preview {
    PreviewContentView {
        VStack {
            WidePriceTagButton(price: 100, text: "Each") {
                // Do something
            }
            
            WidePriceTagButton(price: 100, indicativePrice: 200, text: "Each") {
                // Do something
            }
        }
    }
}
