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
    let value: String
    var maxValue: String = ""
    var image: Image? = nil
    
    var body: some View {
        HStack {
            if let image = self.image {
                YonderIcon(image: image, sideLength: .inspectSheet)
            }
            
            if maxValue.count > 0 {
                HStack(alignment: .lastTextBaseline) {
                    YonderText(text: "\(self.title): \(self.value)", size: .inspectSheetBody)
                    
                    YonderText(text: "/\(self.maxValue)", size: .inspectSheetBody)
                }
            }
            else {
                YonderText(text: "\(self.title): \(self.value)", size: .inspectSheetBody)
            }
        }
    }
}
