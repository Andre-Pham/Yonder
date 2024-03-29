//
//  CardRowView.swift
//  yonder
//
//  Created by Andre Pham on 2/4/2022.
//

import Foundation
import SwiftUI

struct CardRowView: View {
    var prefix: String? = nil
    var value: Int
    var valueColor: Color? = nil
    var indicativeValue: Int? = nil
    var maxValuePrefix: String? = nil
    var maxValue: Int? = nil
    var image: Image? = nil
    var maxValueImage: Image? = nil
    
    var body: some View {
        HStack {
            if let image = self.image {
                YonderIcon(image: image)
            }
            
            HStack(alignment: .lastTextBaseline) {
                if let prefix = self.prefix {
                    YonderTextNumeralHStack {
                        YonderText(text: prefix, size: .cardBody)
                        
                        if let indicativeValue = self.indicativeValue {
                            IndicativeNumeralView(original: self.value, indicative: indicativeValue, size: .cardBody)
                        } else {
                            YonderNumeral(number: self.value, size: .cardBody, color: self.valueColor ?? YonderColors.textMaxContrast)
                        }
                    }
                }
                else {
                    if let indicativeValue = self.indicativeValue {
                        IndicativeNumeralView(original: self.value, indicative: indicativeValue, size: .cardBody)
                    } else {
                        YonderNumeral(number: self.value, size: .cardBody, color: self.valueColor)
                    }
                }
                
                if let maxValue = maxValue {
                    Spacer()
                    
                    YonderTextNumeralHStack {
                        YonderText(text: "/", size: .cardSubscript)
                        
                        if let image = self.maxValueImage {
                            YonderIcon(image: image, sideLength: .cardSubscript)
                                .padding(.horizontal, 3)
                        }
                        
                        if let prefix = self.maxValuePrefix {
                            YonderText(text: prefix, size: .cardSubscript)
                        }

                        YonderNumeral(number: maxValue, size: .cardSubscript)
                    }
                }
            }
        }
    }
}
