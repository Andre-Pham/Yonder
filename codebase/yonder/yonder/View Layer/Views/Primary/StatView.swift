//
//  StatView.swift
//  yonder
//
//  Created by Andre Pham on 18/3/2024.
//

import Foundation
import SwiftUI

struct StatView: View {
    let title: String
    var prefix: String? = nil
    let value: Int
    var indicativeValue: Int? = nil
    var maxValue: Int? = nil
    var image: Image? = nil
    
    var body: some View {
        HStack {
            if let image = self.image {
                YonderIcon(image: image, sideLength: .cardSubscript)
            }
            
            HStack(alignment: .lastTextBaseline) {
                YonderTextNumeralHStack {
                    YonderText(text: "\(self.title): \(self.prefix == nil ? "" : self.prefix!)", size: .buttonBodySubscript)
                    
                    if let indicativeValue = indicativeValue {
                        IndicativeNumeralView(original: self.value, indicative: indicativeValue, size: .buttonBodySubscript)
                    } else {
                        YonderNumeral(number: self.value, size: .buttonBodySubscript)
                    }
                }
                
                if let maxValue = maxValue {
                    YonderTextNumeralHStack {
                        YonderText(text: "/", size: .buttonBodySubscript)
                        
                        YonderNumeral(number: maxValue, size: .buttonBodySubscript)
                    }
                }
            }
        }
    }
}

#Preview {
    PreviewContentView {
        VStack {
            StatView(
                title: "Damage",
                value: 500,
                indicativeValue: 600,
                image: YonderIcons.weaponDamageIcon
            )
            
            StatView(
                title: "Damage",
                value: 500,
                indicativeValue: 200,
                image: YonderIcons.weaponDamageIcon
            )
            
            StatView(
                title: "Gold",
                prefix: "$",
                value: 500,
                image: YonderIcons.goldIcon
            )
            
            StatView(
                title: "Health",
                value: 500,
                maxValue: 600,
                image: YonderIcons.healthIcon
            )
        }
    }
}
