//
//  IndicativeEffectsDescriptionView.swift
//  yonder
//
//  Created by Andre Pham on 27/6/2022.
//

import SwiftUI

struct IndicativeEffectsDescriptionView: View {
    let effectsDescription: String
    let indicative: Int
    let size: YonderTextSize
    var color: Color = YonderColors.textMaxContrast
    
    var body: some View {
        if let original = self.effectsDescription.parseFirstDouble(), let strings = self.effectsDescription.separatedBy(double: original) {
            YonderTextNumeralHStack {
                YonderText(text: strings.0, size: self.size, color: self.color)
                
                IndicativeNumeralView(original: Int(round(original)), indicative: self.indicative, size: self.size)
                
                YonderText(text: strings.1, size: self.size, color: self.color)
            }
        } else if let original = self.effectsDescription.parseFirstInt(), let strings = self.effectsDescription.separatedBy(int: original) {
            // Int has to go second in an else statement, otherwise "20.0%" would register 20 as an Int
            YonderTextNumeralHStack {
                YonderText(text: strings.0, size: self.size, color: self.color)
                
                IndicativeNumeralView(original: original, indicative: self.indicative, size: self.size)
                
                YonderText(text: strings.1, size: self.size, color: self.color)
            }
        } else {
            YonderText(text: self.effectsDescription, size: self.size, color: self.color)
        }
    }
}

struct IndicativeEffectsDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            VStack {
                IndicativeEffectsDescriptionView(effectsDescription: "Inflicts 100 damage.", indicative: 250, size: .buttonBody)
                
                IndicativeEffectsDescriptionView(effectsDescription: "Inflicts 100 damage.", indicative: 50, size: .buttonBody)
            }
        }
    }
}
