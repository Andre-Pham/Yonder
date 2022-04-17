//
//  YonderIconNumeralPair.swift
//  yonder
//
//  Created by Andre Pham on 18/4/2022.
//

import SwiftUI
import MovingNumbersView // https://github.com/aunnnn/MovingNumbersView.git

struct YonderIconNumeralPair: View {
    var prefix: String = ""
    let image: Image
    let numeral: Int
    let size: YonderTextSize
    var color: Color = Color.Yonder.textMaxContrast
    var animationIsActive: Bool = true
    
    var body: some View {
        HStack {
            YonderIcon(image: self.image)
            
            if prefix.count > 0 {
                YonderTextAndNumeral(format: [.text, .numeral], text: [self.prefix], numbers: [self.numeral], size: self.size, color: self.color, animationIsActive: self.animationIsActive)
            }
            else {
                YonderNumeral(number: self.numeral, size: self.size, color: self.color, animationIsActive: self.animationIsActive)
            }
        }
    }
}

struct YonderIconNumeralPair_Previews: PreviewProvider {
    static var previews: some View {
        YonderIconNumeralPair(image: YonderImages.armorPointsIcon, numeral: 500, size: .buttonBody, color: .black)
    }
}
