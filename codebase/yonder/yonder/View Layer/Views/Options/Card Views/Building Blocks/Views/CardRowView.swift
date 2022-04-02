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
    var maxValue: Int? = nil
    var image: Image? = nil
    
    var body: some View {
        HStack {
            if let image = self.image {
                YonderIcon(image: image)
            }
            
            HStack(alignment: .lastTextBaseline) {
                if let prefix = self.prefix {
                    YonderTextAndNumeral(format: [.text, .numeral], text: [prefix], numbers: [self.value], size: .cardBody)
                }
                else {
                    YonderNumeral(number: self.value, size: .cardBody)
                }
                
                if let maxValue = maxValue {
                    Spacer()
                    
                    YonderTextAndNumeral(format: [.text, .numeral], text: ["/"], numbers: [maxValue], size: .cardSubscript)
                }
            }
        }
    }
}
