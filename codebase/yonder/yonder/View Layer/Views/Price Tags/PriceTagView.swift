//
//  PriceTagView.swift
//  yonder
//
//  Created by Andre Pham on 6/5/2022.
//

import SwiftUI

struct PriceTagView: View {
    let price: Int
    
    var body: some View {
        YonderIconNumeralPair(prefix: "$", image: YonderImages.goldIcon, numeral: self.price, size: .buttonBody)
            .padding(.horizontal, YonderCoreGraphics.padding*1.5)
            .padding(.vertical, YonderCoreGraphics.padding)
            .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
    }
}

struct PriceTagView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            PriceTagView(price: 100)
        }
    }
}
