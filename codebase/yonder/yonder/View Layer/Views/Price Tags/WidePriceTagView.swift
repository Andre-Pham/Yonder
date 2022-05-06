//
//  WidePriceTagView.swift
//  yonder
//
//  Created by Andre Pham on 6/5/2022.
//

import SwiftUI

struct WidePriceTagView: View {
    let price: Int
    var text: String = ""
    
    var body: some View {
        HStack(spacing: 0) {
            YonderIconNumeralPair(image: YonderImages.goldIcon, numeral: self.price, size: .buttonBody)
            
            if !self.text.isEmpty {
                YonderText(text: " " + self.text, size: .buttonBody)
            }
        }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, YonderCoreGraphics.padding*1.5)
            .padding(.vertical, YonderCoreGraphics.padding)
            .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
    }
}

struct WidePriceTagView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            WidePriceTagView(price: 100, text: "Each")
        }
    }
}
