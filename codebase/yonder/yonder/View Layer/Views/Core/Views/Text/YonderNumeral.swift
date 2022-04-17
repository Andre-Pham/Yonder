//
//  YonderNumeral.swift
//  yonder
//
//  Created by Andre Pham on 16/4/2022.
//

import SwiftUI

struct YonderNumeral: View {
    let number: Int
    let size: YonderTextSize
    var color: Color
    @State private var animatedNumber: Double
    
    init(number: Int,
         size: YonderTextSize,
         color: Color = Color.Yonder.textMaxContrast) {
        self.number = number
        self.size = size
        self.color = color
        self.animatedNumber = Double(number)
    }
    
    var body: some View {
        AnimatedNumber(self.$animatedNumber)
            .font(YonderFonts.main(size: self.size.value))
            .foregroundColor(self.color)
            .onChange(of: self.number) { newValue in
                self.animatedNumber += Double(newValue - self.number)
            }
    }
}

struct YonderNumeral_Previews: PreviewProvider {
    static var previews: some View {
        YonderNumeral(number: 500, size: .buttonBody, color: .black)
    }
}
