//
//  CardOfferCountView.swift
//  yonder
//
//  Created by Andre Pham on 9/5/2022.
//

import SwiftUI

struct CardOfferCountView: View {
    let offerCount: Int
    var text: String {
        return self.offerCount == 1 ? Strings.Stat.OffersSingular.local : Strings.Stat.Offers.local
    }
    
    var body: some View {
        YonderTextNumeralHStack {
            YonderNumeral(number: self.offerCount, size: .cardSubscript)
            
            YonderText(text: self.text.leftPadded(by: " "), size: .cardSubscript)
        }
    }
}

struct CardOfferCountView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            CardOfferCountView(offerCount: 10)
        }
    }
}
