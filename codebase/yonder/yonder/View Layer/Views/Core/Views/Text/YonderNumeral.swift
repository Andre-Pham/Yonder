//
//  YonderNumeral.swift
//  yonder
//
//  Created by Andre Pham on 16/4/2022.
//

import SwiftUI
import MovingNumbersView // https://github.com/aunnnn/MovingNumbersView.git

struct YonderNumeral: View {
    let number: Int
    let size: YonderTextSize
    var color: Color = Color.Yonder.textMaxContrast
    var animationIsActive: Bool = true
    
    var body: some View {
        MovingNumbersView(
            number: Double(self.number),
            numberOfDecimalPlaces: 0,
            // Work around for iOS15 bug that causes single-digit numbers with exact width to not appear
            // https://github.com/aunnnn/MovingNumbersView/issues/3
            // 15% extra padding isn't that noticeable and fixes the issue
            fixedWidth: (self.number < 10 && self.number > -10) ? self.size.width*(self.number < 0 ? 2 : 1)*1.15 : nil,
            animationDuration: self.animationIsActive ? 0.6 : 0.0) { str in
                // Builds each character
                YonderText(text: str, size: self.size, color: self.color)
        }
    }
}

struct YonderNumeral_Previews: PreviewProvider {
    static var previews: some View {
        YonderNumeral(number: 500, size: .buttonBody, color: .black)
    }
}
