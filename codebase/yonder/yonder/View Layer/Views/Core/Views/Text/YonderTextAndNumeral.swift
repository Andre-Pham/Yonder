//
//  YonderTextAndNumeral.swift
//  yonder
//
//  Created by Andre Pham on 16/4/2022.
//

import SwiftUI
import MovingNumbersView // https://github.com/aunnnn/MovingNumbersView.git

/// Creates a combination of text and numerals with the ordering based on the formatting provided.
///
/// Example:
/// ``` format: [.text, .numeral, .text]
///     text: ["Health: ", "%"]
///     numbers: [500]
/// ```
/// Produces:
/// ``` Health: 500% ```
struct YonderTextAndNumeral: View {
    
    enum YonderTextType {
        case text
        case numeral
    }
    
    let format: [YonderTextType]
    let text: [String]
    let numbers: [Int]
    let size: YonderTextSize
    var color: Color = Color.Yonder.textMaxContrast
    var animationIsActive: Bool = true
    
    var body: some View {
        let orderedText = self.getOrderedText()
        HStack(spacing: 0) {
            ForEach(Array(zip(self.format, orderedText)), id: \.1.self) { textType, textString in
                switch textType {
                case .text:
                    if let textString = textString {
                        YonderText(text: textString, size: self.size, color: self.color)
                    }
                case .numeral:
                    if let textString = textString {
                        YonderNumeral(number: Int(textString)!, size: self.size, color: self.color, animationIsActive: self.animationIsActive)
                    }
                }
            }
        }
    }
    
    func getOrderedText() -> [String?] {
        var orderedText = [String?]()
        var textReversed = Array(text.reversed())
        var numbersReversed = Array(numbers.reversed())
        for format in self.format {
            switch format {
            case .text:
                if let text = textReversed.popLast() {
                    orderedText.append(text)
                } else {
                    orderedText.append(nil)
                }
            case .numeral:
                if let num = numbersReversed.popLast() {
                    orderedText.append(String(num))
                } else {
                    orderedText.append(nil)
                }
            }
        }
        return orderedText
    }
}

struct YonderTextAndNumeral_Previews: PreviewProvider {
    @State var health = 500
    
    static var previews: some View {
        YonderTextAndNumeral(format: [.text, .numeral, .text], text: ["Health: ", "%"], numbers: [500], size: .buttonBody, color: .black)
    }
}
