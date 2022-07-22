//
//  IndicativeNumeralView.swift
//  yonder
//
//  Created by Andre Pham on 25/6/2022.
//

import SwiftUI

struct IndicativeNumeralView: View {
    let original: Int
    let indicative: Int
    let size: YonderTextSize
    private var color: Color {
        if self.indicative > self.original {
            return YonderColors.higherIndicative
        }
        else if self.indicative < self.original {
            return YonderColors.lowerIndicative
        }
        return YonderColors.textMaxContrast
    }
    
    var body: some View {
        YonderNumeral(number: self.indicative, size: self.size, color: self.color)
    }
}

struct IndicativeNumeralView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            VStack  {
                IndicativeNumeralView(original: 5, indicative: 20, size: .buttonBody)
                
                IndicativeNumeralView(original: 20, indicative: 5, size: .buttonBody)
            }
        }
    }
}
