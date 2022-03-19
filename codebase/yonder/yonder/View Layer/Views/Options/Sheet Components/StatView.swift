//
//  StatView.swift
//  yonder
//
//  Created by Andre Pham on 4/2/2022.
//

import Foundation
import SwiftUI

struct StatView: View {
    let title: String
    var prefix: String? = nil
    let value: Int
    var maxValue: Int? = nil
    var image: Image? = nil
    
    var body: some View {
        HStack {
            if let image = self.image {
                YonderIcon(image: image, sideLength: .inspectSheet)
            }
            
            HStack(alignment: .lastTextBaseline) {
                YonderTextAndNumeral(format: [.text, .numeral], text: ["\(self.title): \(self.prefix == nil ? "" : self.prefix!)"], numbers: [self.value], size: .inspectSheetBody)
                
                if let maxValue = maxValue {
                    YonderTextAndNumeral(format: [.text, .numeral], text: ["/"], numbers: [maxValue], size: .inspectSheetBody)
                }
            }
        }
    }
}
