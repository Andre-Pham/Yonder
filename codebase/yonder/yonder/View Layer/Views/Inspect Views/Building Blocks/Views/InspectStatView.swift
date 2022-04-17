//
//  InspectStatView.swift
//  yonder
//
//  Created by Andre Pham on 2/4/2022.
//

import Foundation
import SwiftUI

struct InspectStatView: View {
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
                YonderTextNumeralHStack {
                    YonderText(text: "\(self.title): \(self.prefix == nil ? "" : self.prefix!)", size: .inspectSheetBody)
                    
                    YonderNumeral(number: self.value, size: .inspectSheetBody)
                }
                
                if let maxValue = maxValue {
                    YonderTextNumeralHStack {
                        YonderText(text: "/", size: .inspectSheetBody)
                        
                        YonderNumeral(number: maxValue, size: .inspectSheetBody)
                    }
                }
            }
        }
    }
}
