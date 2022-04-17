//
//  YonderIconNumeralPair.swift
//  yonder
//
//  Created by Andre Pham on 18/4/2022.
//

import SwiftUI

struct YonderIconNumeralPair: View {
    var prefix: String = ""
    let image: Image
    let numeral: Int
    let size: YonderTextSize
    var color: Color = Color.Yonder.textMaxContrast
    
    var body: some View {
        HStack {
            YonderIcon(image: self.image)
            
            if prefix.count > 0 {
                YonderTextNumeralHStack {
                    YonderText(text: self.prefix, size: self.size, color: self.color)
                    
                    YonderNumeral(number: self.numeral, size: self.size, color: self.color)
                }
            }
            else {
                YonderNumeral(number: self.numeral, size: self.size, color: self.color)
            }
        }
    }
}

struct YonderIconNumeralPair_Previews: PreviewProvider {
    static var previews: some View {
        YonderIconNumeralPair(image: YonderImages.armorPointsIcon, numeral: 500, size: .buttonBody, color: .black)
    }
}
