//
//  YonderIconNumeralPair.swift
//  yonder
//
//  Created by Andre Pham on 18/4/2022.
//

import SwiftUI

struct YonderIconNumeralPair: View {
    var prefix: String = ""
    var suffix: String = ""
    let image: Image
    let numeral: Int
    let size: YonderTextSize
    var color: Color = Color.Yonder.textMaxContrast
    var iconSize: YonderIconSize? = nil
    
    var body: some View {
        HStack {
            if let iconSize = self.iconSize {
                YonderIcon(image: self.image, sideLength: iconSize)
            } else {
                YonderIcon(image: self.image)
            }
            
            YonderTextNumeralHStack {
                if !self.prefix.isEmpty {
                    YonderText(text: self.prefix, size: self.size, color: self.color)
                }
                
                YonderNumeral(number: self.numeral, size: self.size, color: self.color)
                
                if !self.suffix.isEmpty {
                    YonderText(text: self.suffix, size: self.size, color: self.color)
                }
            }
        }
    }
}

struct YonderIconNumeralPair_Previews: PreviewProvider {
    static var previews: some View {
        YonderIconNumeralPair(image: YonderImages.armorPointsIcon, numeral: 500, size: .buttonBody, color: .black)
    }
}
